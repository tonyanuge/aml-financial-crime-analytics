-- Week 1: transaction profiling starter
-- Replace table/column names after the training dataset is selected.

-- 1. Basic volume and value profile
SELECT
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_value,
    AVG(amount) AS average_value,
    MIN(amount) AS minimum_value,
    MAX(amount) AS maximum_value
FROM transactions;

-- 2. Customer activity profile
SELECT
    customer_id,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_value,
    AVG(amount) AS average_value
FROM transactions
GROUP BY customer_id
ORDER BY total_value DESC;

-- 3. Daily transaction velocity
SELECT
    customer_id,
    CAST(transaction_timestamp AS DATE) AS transaction_date,
    COUNT(*) AS daily_transaction_count,
    SUM(amount) AS daily_total_value
FROM transactions
GROUP BY customer_id, CAST(transaction_timestamp AS DATE)
ORDER BY daily_transaction_count DESC;

-- Week 1 TODO:
-- Add a first structuring-style detection only after the dataset and
-- business threshold assumptions have been defined.
