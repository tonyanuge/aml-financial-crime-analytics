/* =====================================================================
   Transaction Profiling and Structuring Detection
   Engine: Microsoft SQL Server (T-SQL)

   Purpose: establish the baseline transaction population before applying
   detection logic, then isolate sub-threshold clustering consistent with
   structuring.

   Source: dbo.transactions (txn_id, account_id, direction, amount,
   txn_time, ground_truth).
   ===================================================================== */


/* Dataset grain and volume: row count, distinct accounts, date range. */

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT txn_id) AS distinct_transactions,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    MIN(txn_time) AS first_txn,
    MAX(txn_time) AS last_txn
FROM dbo.transactions;


/* Per-account activity summary: volume and IN/OUT totals per account,
   most active first. Establishes normal account behaviour. */

SELECT
    account_id,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN direction = 'IN'  THEN amount ELSE 0 END) AS total_in,
    SUM(CASE WHEN direction = 'OUT' THEN amount ELSE 0 END) AS total_out,
    AVG(amount) AS average_amount
FROM dbo.transactions
GROUP BY account_id
ORDER BY transaction_count DESC;


/* Daily transaction volume: activity level across the period, used as
   context so a high single-day total is not treated as unusual alone. */

SELECT 
    CAST(txn_time AS DATE) AS transaction_date,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM dbo.transactions
GROUP BY CAST(txn_time AS DATE);


/* Structuring detection: incoming deposits in the 9,000-9,999 band
   (just under a 10,000 reporting threshold), 3 or more on the same day
   for the same account. The daily minimum filters out isolated large
   deposits that are not structuring. */

SELECT 
    account_id, 
    CAST(txn_time AS DATE) AS transaction_date,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM dbo.transactions 
WHERE direction = 'IN' 
  AND amount BETWEEN 9000 AND 9999
GROUP BY 
    account_id, 
    CAST(txn_time AS DATE)
HAVING COUNT(*) >= 3;

/* ========================== Key Findings ===========================================
Normal transactions in the dataset look consistent with standard daily activity, 
usually a single payment in a day, depending on the type of business or payment. 
The payment amounts and frequency also appear consistent with the historical 
transaction patterns of the individual accounts.
However, account 900001 stands out. The deposits are consistently just below 10,000,
mostly between 9,200 and 9,800. This is worth noting because a cluster of round-number
deposits sitting just under 10,000 is a pattern commonly associated with structuring,
not because 10,000 is a legal reporting threshold being avoided here. 10,000 is simply
the round number this pattern happens to sit under, not a confirmed rule for this
dataset or a universal AML reporting limit. There could be a legitimate explanation,
for example a business with a consistent pattern of daily takings.
Another point to note is that 9 transactions were made in a single day.
Taken together, this is a potential structuring indicator, not proof of it, and it
would require further investigation before drawing any conclusion.
===================================================================== */
