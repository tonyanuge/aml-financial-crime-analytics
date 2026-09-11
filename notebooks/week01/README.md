# Week 1: baseline and profiling

**Mission:** build a clean analytical baseline of the data before any detection or modelling. You cannot call something unusual until you know what usual looks like.

**Single required output:** a set of reproducible T-SQL profiling queries in `sql/week01/01_transaction_profile.sql`, plus two or three sentences of plain-English observations.

## Steps
1. The Week 1 synthetic training dataset is already provided at `data/sample_transactions.csv`. (TODO, future: add a generator script here if regenerating/varying the dataset is ever needed.)
2. Load `data/sample_transactions.csv` into SQL Server as `dbo.transactions`.
3. Work through questions yourself.
4. Write your observations: what does normal look like, and what stood out.

## Acceptance criteria
- The queries run and return sensible results.
- No copied word.
- You can explain, what each query shows and why you ran it.

## Do not yet
Do not build detection logic, scoring, graphs or models. That starts in Week 3 onward. Week 1 is only about knowing the data.

When accepted, update `PROGRESS.md` (Week 1 to Accepted) and commit.
