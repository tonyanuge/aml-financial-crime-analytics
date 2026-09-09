/* =====================================================================
   Week 1, Task 1: profile the dataset BEFORE any detection.
   Engine: Microsoft SQL Server (T-SQL).

   Goal: understand the grain, the volumes and the shape of normal
   behaviour, so that later "unusual" actually means something.

   Load sample_transactions.csv into a table called dbo.transactions first
   (Import Wizard or BULK INSERT). Expected columns:
   txn_id, account_id, direction, amount, txn_time, ground_truth

   Rule of the programme: write these yourself. 
   ===================================================================== */


/* Q1 (TODO): what is the grain, and how much data is there? */

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT txn_id) AS distinct_transactions,
    COUNT(DISTINCT account_id) AS distinct_accounts,
    MIN(txn_time) AS first_txn,
    MAX(txn_time) AS last_txn
FROM dbo.transactions;


/* Q2 (TODO): per-account summary.
   For each account return: number of transactions, total IN, total OUT,
   and average amount. Order by transaction count descending.
    */

SELECT
    account_id,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN direction = 'IN'  THEN amount ELSE 0 END) AS total_in,
    SUM(CASE WHEN direction = 'OUT' THEN amount ELSE 0 END) AS total_out,
    AVG(amount) AS average_amount
FROM dbo.transactions
GROUP BY account_id
ORDER BY transaction_count DESC;


/* Q3 (TODO): daily volume.
   Count transactions and total amount per calendar day.
   */

SELECT 
    CAST(txn_time AS DATE) AS transaction_date,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM dbo.transactions
GROUP BY CAST(txn_time AS DATE);


/* Q4 (TODO): first pattern hunt, sub-threshold clustering.
   Find accounts with several IN transactions between 9000 and 9999
   on the same day. This is the structuring shape.
   */

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

/* Self-check only after you have written Q2 to Q4:
   which accounts did your Q4 surface, and do they match the rows where
   ground_truth = 'structuring'?  */


/* ========================== Key Findings ===========================================
Normal transactions in the dataset look consistent with standard daily activity, 
usually a single payment in a day, depending on the type of business or payment. 
The payment amounts and frequency also appear consistent with the historical 
transaction patterns of the individual accounts.
However, account 900001 stands out. The deposits are consistently just below 10,000, 
mostly between 9,200 and 9,800. This is important because they appear to be staying
below a 10,000 reporting threshold, rather than simply reflecting a normal transaction
limit, which could suggest an attempt to avoid triggering reporting requirements.
Another point to note is that 9 transactions were made in a single day. 
This pattern could be a sign of structuring and would require further investigation.
===================================================================== */
