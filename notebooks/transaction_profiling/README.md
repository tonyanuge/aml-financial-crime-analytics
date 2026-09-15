# Transaction Profiling and Structuring Detection

Establishes the baseline transaction population before applying detection logic, then isolates sub-threshold clustering consistent with structuring.

## Contents

- Detection logic: `sql/transaction_profiling/01_transaction_profile.sql`
- Investigation write-up: `reports/case-studies/transaction_profiling_and_structuring_investigation.md`
- Source data: `data/sample_transactions.csv` (synthetic)

## Summary

Profiling of the transaction population established normal account and daily activity across the dataset. A structuring detection query then isolated a single account receiving repeated incoming deposits held just below the €10,000 reporting threshold on the same day, a pattern consistent with structuring and referred for further investigation.