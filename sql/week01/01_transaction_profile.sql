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

-- your query here


/* Q2 (TODO): per-account summary.
   For each account return: number of transactions, total IN, total OUT,
   and average amount. Order by transaction count descending.
    */

-- your query here


/* Q3 (TODO): daily volume.
   Count transactions and total amount per calendar day.
    */

-- your query here


/* Q4 (TODO): first pattern hunt, sub-threshold clustering.
   Find accounts with several IN transactions between 9000 and 9999
   on the same day. This is the structuring shape.
    */

-- your query here


/* Self-check only after you have written Q2 to Q4:
   which accounts did your Q4 surface, and do they match the rows where
   ground_truth = 'structuring'? Note any misses in PROGRESS.md. */
