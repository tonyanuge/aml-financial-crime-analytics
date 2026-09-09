# Week 1: baseline and profiling

**Mission:** build a clean analytical baseline of the data before any detection or modelling. You cannot call something unusual until you know what usual looks like.

**Single required output:** a set of reproducible T-SQL profiling queries in `sql/week01/01_transaction_profile.sql`, plus two or three sentences of plain-English observations.

## Steps
1. Generate the data: `python data/generate_synthetic_transactions.py`.
2. Load `data/sample_transactions.csv` into SQL Server as `dbo.transactions`.
3. Work through Q1 to Q4 in the SQL file. Write Q2 to Q4 yourself.
4. Write your observations: what does normal look like, and what stood out.

## Acceptance criteria
- The queries run and return sensible results.
- Q2 to Q4 are your own work, not copied.
- You can explain, in an interview, what each query shows and why you ran it.
- You noted whether your Q4 output matches the planted `structuring` rows, and recorded any miss.

## Do not yet
Do not build detection logic, scoring, graphs or models. That starts in Week 3 onward. Week 1 is only about knowing the data.

When accepted, update `PROGRESS.md` (Week 1 to Accepted) and commit.
