# The Invisible Network
### Detecting coordinated laundering networks that pass every individual alert

A financial-crime analytics project that hunts the money-laundering activity conventional monitoring misses: networks engineered so that every account looks clean on its own, sits below every threshold, and clears rule-based transaction monitoring, yet together form a single coordinated laundering ring.

The work builds a rules-only baseline, lets it fail the way real systems fail, then layers SQL detection, behavioural profiling, graph network analysis and a machine-learning challenger on top to expose the ring underneath, and measures the lift. It closes the way a real case closes: an investigation, a decision, and an FIU Ireland-style suspicious transaction report.

> ### `N` accounts. `0` individual alerts. `1` coordinated laundering network.
> Headline metrics are generated from the experiment, not predetermined. Figures are populated from each run.

---

## Project status

This is an ongoing, self-directed AML / financial-crime analytics programme, currently at an early stage. The SQL detection, Python profiling, graph/network analysis, machine-learning challenger, investigation case documentation and Power BI dashboard described below are the planned end-state of the programme, not the current implementation. Live, up-to-date progress is tracked in [`docs/PROGRESS.md`](docs/PROGRESS.md).

---

## What this demonstrates

- **Detection, not just description.** Rules and SQL detections for structuring, velocity, rapid movement and linked accounts, benchmarked against a deliberately weak rules-only baseline.
- **Graph thinking.** Network analysis that surfaces circular flows, mule chains and connected entities that transaction-level checks cannot see.
- **A measurable edge.** A scored comparison of challenger detection against the baseline: detection rate, false-positive reduction, and the network the rules-only view scored as clean.
- **The validator's mindset.** A model challenge section that turns on its own detection: where it produces false positives, where bias sits, what a reviewer or defence would attack, and what would not yet be safe to deploy.
- **Real casework, not a demo.** An end-to-end investigation from alert to evidence to decision, anchored in the Irish and EU AML framework and ending in an STR-style narrative.

---

## The flagship: The Invisible Network

The centrepiece uses an adversarial, self-authored synthetic dataset in which the laundering network is designed in deliberately, with a known hidden ground truth, so the system can be proven to have found what was planted rather than hoping a public dataset happens to contain something interesting.

The build runs in a fixed arc:

1. **Baseline.** A rules-only transaction-monitoring layer, built to underperform on purpose, with its misses documented.
2. **Reveal.** SQL detections, Python and pandas behavioural profiling, and NetworkX relationship and circular-flow analysis expose the coordinated network.
3. **Score.** Challenger-versus-baseline lift: detection rate up, false positives down, the ring caught that rules alone missed.
4. **Challenge.** A written defence of the model covering weaknesses, bias, assumptions and deployment limits.
5. **Report.** An end-to-end investigation and an FIU Ireland-style STR narrative on the specific network found.

Every headline figure is produced by the experiment.

---

## Core capability areas

The project is built across six areas of financial-crime analytics:

1. **AML fundamentals and typologies:** structuring, layering, mule accounts, funnel accounts, circular flows, shell companies, TBML and crypto layering.
2. **Transaction monitoring and investigations:** alert triage, customer-profile comparison, source and destination analysis, false positives, escalation and case narratives.
3. **KYC, CDD and EDD, plus sanctions and PEP screening.**
4. **Irish and EU AML workflow:** Irish obligations, FIU Ireland, STRs, goAML and the EU AML framework.
5. **SQL for AML analytics:** joins, CTEs, window functions, rolling totals, pattern detection, velocity checks and linked-account analysis.
6. **Python and data analytics:** pandas, aggregation, anomaly detection, threshold tuning, false-positive analysis and model evaluation.

---

## Build progression

The body of work is organised as eight incremental stages, each producing evidence that feeds the flagship case.

| Stage | Focus |
|---|---|
| 1 | AML foundations, Irish and EU context, SQL profiling |
| 2 | KYC, CDD and EDD, sanctions and PEP, customer-risk SQL |
| 3 | Transaction monitoring, structuring, layering and funnel detection |
| 4 | TBML, crypto, Python and pandas foundations |
| 5 | Investigations, funds tracing, case narratives |
| 6 | Network analytics, circular flows, entity relationships |
| 7 | Detection engine, threshold tuning, anomaly detection, model evaluation and validation |
| 8 | FIU Ireland and goAML workflow, Power BI, integrated capstone |

---

## Repository structure

```text
data/                  Synthetic and processed datasets
sql/                   AML detection and investigation SQL
notebooks/             Python and Jupyter analysis
src/aml_analytics/     Reusable Python code
reports/case-studies/  Investigation write-ups and capstone evidence
dashboards/            Power BI artefacts and exports
docs/                  Reference notes and the capstone specification
tests/                 Tests for reusable analytics code
```

---

## Stack

- **SQL:** Microsoft SQL Server (T-SQL) as the primary engine for AML analytics and detection work. DuckDB is supported only for portable local testing where useful.
- **Python:** pandas, NumPy, scikit-learn, NetworkX, pyvis, Jupyter.
- **Visualisation:** Power BI for the investigator and management view, pyvis for interactive network graphs.
- **Version control:** Git and GitHub.
- **Data:** synthetic and self-authored only. No real customer or transaction data is used at any point.

---

## Context

This project sits in the Irish and EU financial-crime environment: the Criminal Justice (Money Laundering and Terrorist Financing) Act, FIU Ireland and goAML reporting, Central Bank of Ireland supervision, and the EU AML framework including the new Anti-Money Laundering Authority. Detection and reporting choices are framed against that regime.
