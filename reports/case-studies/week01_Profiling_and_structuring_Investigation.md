Transaction Profiling and Structuring Investigation

Objective

The main objective for Week 1 was to understand the transaction dataset before trying to identify suspicious activity.

The focus was to use SQL to understand the size of the data, transaction activity by account, daily transaction volumes and then apply conditions to identify transactions that may require further investigation.

The main AML pattern investigated this week was possible structuring.

Method.

The transaction CSV file was loaded into SQL Server as the dbo.transactions table.

Before applying any suspicious activity rules, the dataset was first queried to understand the transaction population and general account behaviour.

For Q2, a per-account summary was created to return:

number of transactions per account
total incoming transactions
total outgoing transactions
average transaction amount

The results were ordered by transaction count descending so that the most active accounts could be reviewed first.

For Q3, transaction activity was grouped by calendar day to return the number of transactions and total transaction amount per day.

This was used to understand the general level of transaction activity across the dataset before applying a more specific detection rule.

For Q4, a structuring query was then created to identify accounts receiving repeated incoming transactions of similar values.

The conditions used were:

transaction direction must be IN
transaction amount between €9,000 and €9,999
at least 3 transactions on the same day for the same account

The results were grouped by account and transaction date.

Findings.

The Q2 per-account summary returned 2,004 accounts.

The query showed transaction count, total incoming amount, total outgoing amount and average transaction amount for each account.

The highest transaction count shown in the results was 39 transactions for an account.

This gave an initial view of how transaction activity was spread across the account population and provided a baseline before applying suspicious activity conditions.

The Q3 daily-volume query returned 90 days of transaction activity.

Daily transaction counts were generally in the hundreds.

Examples from the results included:

29 September 2026: 498 transactions totalling €117,065.35
3 September 2026: 514 transactions totalling €114,881.99
11 August 2026: 509 transactions totalling €151,470.88

This showed that the dataset had regular transaction activity across the period and that daily transaction values could exceed €100,000 without that alone being unusual.

The key finding came from Q4.

The structuring query returned only account 900001.

The account received 9 incoming transactions on 4 August 2026, with a total value of €85,141.14.

All 9 transactions were between €9,000 and €9,999.

Further review showed that the individual transactions were closely grouped in value and occurred within a short period on the same day.

This made account 900001 stand out from the wider transaction population.

Analysis.

The Q2 and Q3 queries were important because they gave context before trying to identify suspicious activity.

The per-account summary showed how active individual accounts were, while the daily-volume query showed the general level of transaction activity across the full dataset.

This helped avoid treating a high transaction total by itself as suspicious.

The Q4 query then applied a more specific pattern.

Account 900001 received 9 incoming transactions in one day, all within a narrow value range between €9,000 and €9,999.

The total incoming amount was €85,141.14.

The concern is not only the total amount, but the repeated use of similar transaction values over a short period.

This creates a pattern that could be consistent with structuring.

However, the query only identifies an unusual transaction pattern. It does not prove that the customer was deliberately trying to avoid a reporting threshold or that money laundering had taken place.

Further investigation would therefore be required.

Limitations.

The main limitation in Week 1 was that the analysis was based mainly on transaction data.

The transaction data does not explain who the customer is, what their expected activity should be, their occupation, declared income, account type or overall customer risk.

The €9,000 to €9,999 condition is also a hardcoded rule used for the training exercise.

In a real AML monitoring environment, relying on one fixed transaction range would be limited because suspicious behaviour can happen at different transaction values.

The Q2 results also show the highest transaction count in the displayed output, but this should not be treated as the normal transaction count across the whole population without further statistical analysis.

The structuring query also identifies a transaction pattern but does not explain the source of funds, purpose of the transactions or relationship between the parties.

These areas would require further investigation.

Conclusion.

Week 1 showed the importance of first understanding the transaction population before applying suspicious activity rules.

The per-account and daily-volume queries provided a baseline of general transaction activity across 2,004 accounts and 90 days of data.

The structuring query then narrowed the population down to one account, 900001, which received 9 incoming transactions totalling €85,141.14 on 4 August 2026.

The repeated transactions, similar values and concentration of activity within one day make the account unusual enough to require further investigation.