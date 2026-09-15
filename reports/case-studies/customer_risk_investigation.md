\### Method



The sample customer and transaction tables were joined using the account ID to compare each customer's KYC profile against their actual transaction activity.



Initial queries were used to identify customers with higher-risk factors, including PEP status, customers linked to selected higher-risk countries, and customers whose incoming transaction activity was significantly higher than their declared income.



Transaction activity was then aggregated at account level to calculate transaction counts, total incoming funds and identify accounts that stood out for further investigation.



A second layer of analysis was applied using a composite risk score:



\* +2 if the customer is a PEP

\* +2 if linked to a higher-risk country

\* +1 if the customer is a business

\* +3 if an income mismatch was identified



For the income mismatch test, customers were flagged where total incoming transactions were more than twice their declared annual income and total incoming funds were at least €20,000.



\### Findings



The first population check identified 21 customers as higher risk based on the risk conditions applied.



Of the 21 customers:



\* 3 were identified as PEPs.

\* 7 customers were linked to Cyprus.

\* 5 customers were linked to the United Arab Emirates.

\* 6 customers were linked to Panama.



The PEP countries should be confirmed directly against the customer KYC data before being included in the final report.



One of the key findings was customer C0301, Kevin Whelan, where the customer's transaction activity was significantly higher than the income recorded in the KYC profile.



Kevin Whelan had a declared \*\*annual income of €38,000\*\*. However, the account received \*\*9 incoming transactions totalling €85,141.14 in a single day\*\*, with an average transaction value of €9,460.13.



Further review showed that all 9 transactions occurred on 4 August 2026 between 00:00 and 08:00, with approximately one transaction every hour. The individual transaction values were closely grouped, ranging from €9,257.12 to €9,663.63.



The €85,141.14 received in that single day was therefore \*\*more than twice the customer's entire declared annual income of €38,000\*\*.



The composite risk scoring also helped identify additional accounts that were not as obvious from the initial higher-risk-country and PEP queries. This included customers recorded with occupations such as student or PAYE employment while holding business-type accounts.



This does not automatically indicate suspicious activity, but the inconsistency between the customer's stated profile and account type provides a reason for further review.



\### Analysis



Customer C0301 raised the strongest concern from the investigation.



The main concern is not only that €85,141.14 was received against a declared annual income of €38,000, but that the entire amount was received within a single day.



Nine incoming payments were made within approximately nine hours, with each transaction being of a very similar value.



The combination of:



\* a single day's incoming funds exceeding twice the customer's declared annual income,

\* repeated transactions within a short period,

\* closely grouped transaction values, and

\* individual transactions consistently below €10,000



creates a pattern consistent with possible structuring.



This does not prove money laundering or criminal activity. However, the activity is significantly inconsistent with the customer's known KYC profile and provides sufficient grounds for Enhanced Due Diligence and further investigation.



Further investigation should include reviewing the source of funds, purpose of the payments, transaction counterparties, expected account activity, historical account behaviour and whether there is a reasonable economic explanation for the activity.



\### Limitations



The dataset presents several limitations.



There are inconsistencies between some customer occupations and account types. For example, customers recorded as students or PAYE employees may hold business accounts. These may be legitimate arrangements, but the available data does not contain enough information to establish the relationship between the customer's occupation and the business account.



The composite risk score is also a basic rules-based model. It helps prioritise customers for investigation but does not distinguish between genuinely suspicious activity and customers who trigger risk factors for legitimate reasons.



The €20,000 transaction floor and two-times-income threshold are hardcoded assumptions used for this exercise. In a production AML environment, thresholds should be risk-based, segmented by customer and account type, tested against historical behaviour and periodically tuned.



The country list used in the SQL is also a simplified training list and should not be treated as a current regulatory high-risk-country list.



There is also an inconsistency within the SQL itself. The Q3 guidance comment refers to activity above three times declared income, while the implemented query uses a two-times-income threshold. The final methodology should clearly state which rule has been adopted.



\### Conclusion



Customer C0301, Kevin Whelan, should be escalated for Enhanced Due Diligence.



The account received \*\*€85,141.14 through nine incoming transactions within approximately nine hours on 4 August 2026\*\*, despite the customer having a declared \*\*annual income of €38,000\*\*.



This means that the incoming funds received in a single day were more than twice the customer's entire declared annual income.



The transaction frequency, closely grouped payment amounts and significant mismatch against the customer's known income are consistent with a possible structuring typology.



The activity should therefore be treated as an indicator requiring further investigation rather than evidence of money laundering. The next step would be to establish the source and purpose of the funds and determine whether the activity has a reasonable explanation before deciding whether further escalation or reporting is required.



