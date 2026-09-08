# AML Financial Crime Analytics Lab

An 8-week hands-on portfolio project focused on becoming job-ready for AML / Financial Crime Analytics work in Ireland, with practical SQL and Python capability.

**Status:** Proposed programme — repo setup started 8 September 2026. Training has not yet been formally committed.

## Core scope

The programme is governed by six locked areas:

1. **AML fundamentals and typologies** — structuring, layering, mule accounts, funnel accounts, circular flows, shell companies, TBML and crypto layering.
2. **Transaction monitoring and investigations** — alert triage, customer-profile comparison, source/destination analysis, false positives, escalation and case narratives.
3. **KYC / CDD / EDD + sanctions / PEP screening**.
4. **Irish / EU AML workflow** — Irish obligations, FIU Ireland, STRs, goAML and the EU AML framework.
5. **SQL for AML analytics** — joins, CTEs, window functions, rolling totals, pattern detection, velocity checks and linked-account analysis.
6. **Python / data analytics** — pandas, aggregation, anomaly detection, threshold tuning, false-positive analysis and basic ML evaluation.

## 8-week structure

| Week | Focus |
|---|---|
| 1 | AML foundations + Irish/EU context + SQL profiling |
| 2 | KYC/CDD/EDD + sanctions/PEP + customer-risk SQL |
| 3 | Transaction monitoring + structuring/layering/funnel detection |
| 4 | TBML + crypto + Python/pandas |
| 5 | Investigations + funds tracing + case narratives |
| 6 | Network analytics + circular flows + entity relationships |
| 7 | Detection engine + threshold tuning + anomaly detection + ML evaluation |
| 8 | FIU Ireland/goAML + Power BI + integrated capstone |

## Repository structure

```text
data/                  Synthetic/raw and processed datasets
sql/                   AML detection and investigation SQL
notebooks/             Python/Jupyter analysis by week
src/aml_analytics/     Reusable Python code
reports/case-studies/  Investigation write-ups and capstone evidence
dashboards/             Power BI artefacts / exports
docs/                   Programme planner and Ireland/EU reference notes
tests/                  Tests for reusable analytics code
```

## Tools

- SQL: PostgreSQL or DuckDB
- Python: pandas, NumPy, scikit-learn, Jupyter
- Visualisation: Power BI
- Version control: Git/GitHub
- Data: synthetic AML/payment datasets only

## Week 1 objective

Build a clean analytical baseline before any advanced modelling:

- understand the transaction dataset and its grain
- profile customers and payments
- identify basic suspicious patterns
- write reproducible SQL queries
- document only the analytical conclusion and evidence needed to defend it

See [`notebooks/week01/README.md`](notebooks/week01/README.md) and [`sql/week01/01_transaction_profile.sql`](sql/week01/01_transaction_profile.sql).

## Governance rule

The six core scope areas above remain locked unless explicitly changed. Certifications are **not** part of this repository scope.
