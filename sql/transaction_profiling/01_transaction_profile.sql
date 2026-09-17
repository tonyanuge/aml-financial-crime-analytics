/*
1. For each account, show each transaction with its running count of transactions over time (1st, 2nd, 3rd...). 
Window function, ordered by time. (This is ROW_NUMBER() or COUNT(*) OVER, your choice, tell me why you picked which.)

2. For each account, show each transaction alongside the account's average amount, 
on every row, without collapsing the rows. (Hint: AVG(amount) OVER (PARTITION BY account_id), 
no ORDER BY needed. Notice how this differs from a GROUP BY average.)

3. For each transaction, show the time gap since that account's previous transaction. 
(Hint: LAG(txn_time) OVER (PARTITION BY account_id ORDER BY txn_time), then DATEDIFF. T
his is the direct foundation of velocity detection in Week 3, so it's the important one.)

4. Using a CTE: first build per-account totals (count, total in, total out), then in the main
query return only the accounts whose transaction count is in the top 10 by count. (Combines CTE with ordering/TOP.)

5. Two CTEs chained: one for per-account daily transaction counts, then a second that finds accounts 
appearing on 3 or more distinct days. (Stretch one; if it walls you, show me where and I'll teach from there.)

*/


--Solution 1.
	SELECT 
    account_id, 
    txn_time,
    amount,
    ROW_NUMBER() OVER (
        PARTITION BY account_id 
        ORDER BY txn_time
    ) AS count_over_time
FROM transactions;

-- I chose row_number over count because it represents a sequential of incremental count that returns 1st, 2nd, 3rd over time.

-- Solution 2
SELECT 
	account_id, 
    txn_time,
    amount,
	AVG(amount) OVER (PARTITION BY account_id) AS avg_amount

FROM transactions
ORDER BY amount DESC;

-- Solution 3
SELECT 
    account_id, 
    txn_time,
    amount,
    LAG(txn_time) OVER (
        PARTITION BY account_id 
        ORDER BY txn_time
    ) AS prev_txn_time,
    DATEDIFF(
        minute, 
        LAG(txn_time) OVER (PARTITION BY account_id ORDER BY txn_time), 
        txn_time
    ) AS time_gap_minutes
FROM transactions
ORDER BY amount DESC;

-- Solution 4

WITH per_account_totals AS (
    SELECT 
        account_id,
        COUNT(*) AS total_count,
        SUM(CASE WHEN direction = 'IN'  THEN amount ELSE 0 END) AS total_in,
        SUM(CASE WHEN direction = 'OUT' THEN amount ELSE 0 END) AS total_out
    FROM transactions
    GROUP BY account_id
)
SELECT TOP 10 
    account_id,
    total_count,
    total_in,
    total_out
FROM per_account_totals
ORDER BY total_count DESC;

-- Solution 5
WITH daily_counts AS (
    SELECT
        account_id,
        CAST(txn_time AS DATE) AS txn_date,
        COUNT(*) AS txns_that_day
    FROM dbo.transactions
    GROUP BY account_id, CAST(txn_time AS DATE)
)

, active_accounts AS (
    SELECT
        account_id,
        COUNT(*) AS active_days
    FROM daily_counts
    GROUP BY account_id
    HAVING COUNT(*) >= 3
)
SELECT account_id, active_days
FROM active_accounts
ORDER BY active_days DESC;

--5. Two CTEs chained: one for per-account daily transaction counts, then a second that finds accounts appearing on 3 or more distinct days