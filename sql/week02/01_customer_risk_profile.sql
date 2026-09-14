/* =====================================================================
   Customer Risk Profiling
   Engine: Microsoft SQL Server (T-SQL)

   Purpose: assess risk at the customer level, not the transaction level.
   Applies the risk-based approach by measuring each customer's actual
   activity against their KYC profile, then ranks customers by a composite
   risk score to prioritise Enhanced Due Diligence.

   Source: dbo.sample_customers joined to dbo.transactions on account_id.
   ===================================================================== */


/* Customer-to-behaviour join: one row per customer, KYC profile beside
   actual transaction activity. LEFT JOIN retains customers with no
   transactions so the population is fully covered. */

SELECT
    c.customer_id,
    c.full_name,
    c.customer_type,
    c.country,
    c.declared_income,
    c.pep_flag,
    COUNT(t.txn_id)                                              AS txn_count,
    SUM(CASE WHEN t.direction = 'IN'  THEN t.amount ELSE 0 END)  AS total_in,
    SUM(CASE WHEN t.direction = 'OUT' THEN t.amount ELSE 0 END)  AS total_out
FROM dbo.sample_customers AS c
LEFT JOIN dbo.transactions AS t
       ON t.account_id = c.account_id
GROUP BY c.customer_id, c.full_name, c.customer_type,
         c.country, c.declared_income, c.pep_flag;


/* Risk flag: classifies a customer as High where they are a PEP, are
   linked to a higher-risk country, or are a business. The country list is
   a simplified training set; in production this maps to the FATF list. */

 WITH simple_risk_flag AS (
    SELECT 
        customer_id,
        full_name,
        occupation,
		country,
        CASE 
            WHEN pep_flag = 'Y' 
             OR country IN ('Panama', 'Cyprus', 'United Arab Emirates') 
             -- OR occupation = 'Public Official'  
            THEN 'High'
            ELSE 'Standard'
        END AS risk_flag
    FROM dbo.sample_customers
)
SELECT 
    customer_id,
    full_name,
    occupation,
	country,
    risk_flag
FROM simple_risk_flag
WHERE risk_flag = 'HIGH';


/* Income-versus-behaviour mismatch: flags customers whose incoming funds
   are inconsistent with declared income. Two branches: zero declared
   income with active inflow, and inflow of 2x or more declared income.
   The 20,000 materiality floor excludes trivial amounts; both thresholds
   are hardcoded placeholders to be tuned and segmented in production. */

WITH per_customer_in AS (
    SELECT 
        account_id,
        SUM(CASE WHEN direction = 'IN' THEN amount ELSE 0 END) AS total_in
    FROM dbo.transactions 
    GROUP BY account_id
)
SELECT 
    s.customer_id,
    s.full_name,
    s.declared_income,
    bm.total_in,
    CASE 
        WHEN ISNULL(s.declared_income, 0) = 0 AND bm.total_in > 0 THEN 'EDD Required (Zero Income / Active Trans)'
        WHEN bm.total_in >= (s.declared_income * 2) THEN 'EDD Required (Income Mismatch)'
        ELSE 'Standard'
    END AS edd_flag
FROM dbo.sample_customers s
INNER JOIN per_customer_in bm 
    ON s.account_id = bm.account_id 
WHERE bm.total_in > (ISNULL(s.declared_income, 0) * 2)
  AND bm.total_in >= 20000


/* Composite risk score: weights the risk factors into a single ranking to
   prioritise customers for review. Weights are a deliberate design choice
   (income mismatch carries the most, business type the least). */

WITH composite_risk AS (
    SELECT 
        account_id,
        SUM(CASE WHEN direction = 'IN' THEN amount ELSE 0 END) AS total_in
    FROM dbo.transactions 
    GROUP BY account_id
)
SELECT 
    s.customer_id,
    s.full_name,
	s.account_id,
	customer_type,
	country,
	occupation,
    (
        (CASE WHEN s.pep_flag = 'Y' THEN 2 ELSE 0 END) +                              -- PEP
        (CASE WHEN s.country IN ('Panama', 'Cyprus', 'United Arab Emirates') THEN 2 ELSE 0 END) +  -- higher-risk country
        (CASE WHEN s.customer_type = 'Business' THEN 1 ELSE 0 END) +                  -- business type
        (CASE WHEN bm.total_in > (ISNULL(s.declared_income, 0) * 2) AND bm.total_in >= 20000 THEN 3 ELSE 0 END)  -- income mismatch
    ) AS risk_score
FROM dbo.sample_customers s
LEFT JOIN composite_risk bm 
    ON s.account_id = bm.account_id
ORDER BY risk_score DESC;


