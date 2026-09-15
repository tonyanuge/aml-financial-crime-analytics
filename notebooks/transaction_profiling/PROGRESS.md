# Project Progress

Single source of truth for status. Updated and committed at the end of each working session. The Git history holds the full audit trail, so this file stays short.

## Dataset provenance

Working dataset: 43,616 transactions across 2,004 accounts, spanning 1 August to 29 October 2026 (`dbo.transactions`). Customer and KYC reference data: `dbo.sample_customers`. All data is synthetic and safe to publish.

## Current state

Completed: transaction profiling and structuring detection, and customer risk profiling.
Next: sanctions and PEP screening (SQL exact matching, then Python fuzzy matching).

## Deliverable status

| Deliverable | Status | Artefacts |
|---|---|---|
| Transaction profiling and structuring detection | Complete | `sql/transaction_profiling/01_transaction_profile.sql`, `reports/case-studies/transaction_profiling_and_structuring_investigation.md` |
| Customer risk profiling | Complete | `sql/customer_risk/01_customer_risk_profile.sql`, `reports/case-studies/customer_risk_investigation.md` |
| Sanctions and PEP screening | Next | |
| Transaction monitoring and typology detection | Planned | |
| Network and entity analytics | Planned | |
| Detection tuning and model validation | Planned | |
| Investigation, reporting and capstone | Planned | |

Status values: Planned, In progress, Complete.

## Decision log

One line per material decision.

- 2026-09-08: Architecture set to a single project with the repository as the source of truth.
- 2026-09-15: Repository reorganised around investigations rather than sequential folders; commit history reframed to project language.