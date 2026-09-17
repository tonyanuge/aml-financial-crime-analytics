Sanctions and PEP Screening Investigation

Method



This case study tested a layered sanctions and PEP screening approach using synthetic customer and watchlist data.



The aim was to understand the limitations of basic SQL matching and then assess whether fuzzy name matching and alias handling could improve the identification of realistic name variations without creating an excessive number of review candidates.



The first stage used SQL to establish the baseline.



Customer full\_name values were matched directly against the watchlist listed\_name.



Exact full-name matching returned 9 candidate matches, made up of 3 sanctions matches and 6 PEP matches.



The SQL logic was then widened to surname-only matching.



Surnames were extracted from both the customer and watchlist names and compared directly. This increased the results to 164 customer-watchlist candidate pairs.



Country was then added as a supporting identifier, which reduced the candidate population from 164 to 71.



The second stage used Python with pandas and RapidFuzz.



Each customer name was compared against watchlist names using fuzz.ratio, which returned a similarity score between 0 and 100.



The highest-scoring watchlist name was retained for each of the 304 customer records.



The score distribution was reviewed before deciding on a screening threshold.



Similarity scores ranged from 31.25 to 100, with a mean of approximately 65.19 and a median of 66.67.



Thresholds of 85 and 90 were compared before a final threshold of 90 was selected.



The reason for selecting 90 was to reduce false-positive review volume while still retaining stronger spelling, punctuation and transliteration variations.



The final stage extended the screening logic beyond the primary listed\_name to include alias\_1 and alias\_2.



For each customer, the process retained the best matching name, similarity score, watchlist ID, watchlist type and the source of the match.



Findings



The SQL baseline showed the limitations of both strict and broad matching.



Exact full-name matching returned only 9 candidates.



This produced a small review population but could not identify spelling, punctuation or transliteration variations.



Surname-only matching increased the results to 164 customer-watchlist candidate pairs.



Adding country as a supporting identifier reduced the population to 71.



This showed that secondary identifiers can help reduce false-positive review volume, although they should support the screening decision rather than determine it on their own.



Primary-name fuzzy matching identified several name variations that exact SQL matching would not recognise.



Examples included:



Ravi Okafor → Ravi Okafour: 95.65

Noah Muller → Noah Müller: 90.91

Aoife Patel → Aiofe Patel: 90.91

Daniel McCarthy → Daniel Mc Carthey: 93.75

Chen O'Connor → Chen O Connor: 92.31



The threshold comparison also identified an important false-negative case.



Sophie Walsh matched the primary watchlist name Sofie Walsh at approximately 86.96.



At the selected threshold of 90, this record was excluded.



Alias handling then showed two different effects.



For Ravi Okafor, the primary-name fuzzy match against Ravi Okafour was already above threshold at 95.65.



Matching against alias\_1 increased the score to 100.



In this case, the alias strengthened an existing candidate but did not change whether the customer was included in the screening results.



For Sophie Walsh, the result was different.



The primary-name score of 86.96 was below the selected threshold.



Once aliases were included, Sophie Walsh matched alias\_1 at 100 and was recovered as a screening candidate.



This changed the actual screening outcome rather than simply improving the score.



At a threshold of 90, primary-name fuzzy matching produced 20 candidate rows.



Alias-aware matching increased this to 22.



The two additional rows were both separate Sophie Walsh customer records that had been excluded under primary-name matching and recovered through alias\_1.



The dataset also contains repeated customer names that represent separate customer records.



This means candidate numbers need to be interpreted at customer-record level using customer\_id and other identifiers rather than deduplicating on full\_name alone.



Analysis



The results showed why sanctions and PEP screening should use a layered approach rather than depend on one matching rule.



Exact SQL matching produced a clean and low-volume result, but it was too strict when dealing with normal identity variations.



Small differences in spelling, punctuation, accents or transliteration were enough to prevent otherwise plausible candidates from matching.



Surname-only matching moved too far in the opposite direction.



The increase from 9 exact matches to 164 surname-based candidate pairs showed how a broad matching rule can quickly create a large false-positive review population.



Adding country reduced the population to 71, which showed the value of supporting identifiers in narrowing the results.



Fuzzy matching provided a better middle ground by converting name similarity into a measurable score.



The selected threshold of 90 retained strong variants such as Ravi Okafor / Ravi Okafour, Noah Muller / Noah Müller and Chen O'Connor / Chen O Connor, while excluding weaker similarities.



The Sophie Walsh / Sofie Walsh result showed the main trade-off with threshold tuning.



A similarity score of 86.96 represents a plausible spelling variation, but it fell below the selected threshold.



This shows that increasing the threshold can reduce analyst review volume, but it also increases false-negative risk.



Alias handling reduced part of this risk.



The Ravi Okafor case showed confidence improvement because the customer was already identified at 95.65, with the alias increasing the score to 100.



The Sophie Walsh case showed additional detection because the customer had been excluded under primary-name matching but was recovered through an alias at 100.



The increase from 20 to 22 candidates therefore has a clear explanation.



The alias layer recovered two customer records that would otherwise have remained below the selected threshold.



The exercise therefore supports a screening approach where exact matching, fuzzy similarity, known aliases and supporting identifiers work together.



No single matching method was enough on its own.



Limitations



The customer and watchlist data used in this exercise are synthetic and deliberately contain known spelling, formatting and alias variations.



The results therefore show how the screening logic behaves, but they should not be treated as evidence of production screening performance.



The threshold of 90 was selected by reviewing this dataset rather than validating the logic against a large independently labelled population of confirmed true and false matches.



Precision, recall, false-positive rate and false-negative rate have therefore not yet been formally measured.



The Sophie Walsh case also demonstrates a real limitation of the selected threshold.



Without the matching alias, the plausible Sophie Walsh / Sofie Walsh variation would have been excluded.



Country was used as a supporting SQL attribute, but country or nationality data can be missing, inconsistent or legitimately different between records.



It should therefore not be used on its own to dismiss a possible sanctions or PEP match.



Repeated names can also represent different customers.



The screening output therefore needs to retain record-level identifiers such as customer\_id rather than deduplicating solely on name.




Conclusion



The investigation showed that effective sanctions and PEP screening requires a layered matching approach.



Exact matching, fuzzy name similarity, aliases and supporting identifiers all provide different levels of value.



A similarity threshold of 90 was selected to reduce false-positive review volume, with a known false-negative trade-off demonstrated by the primary-name Sophie Walsh / Sofie Walsh result.



Alias matching materially changed the outcome by recovering two customer records that fell below the primary-name threshold.



It also strengthened existing candidates, as shown in the Ravi Okafor case where the score increased from 95.65 to 100.



Before this type of matching logic could be used in production, the threshold and overall screening approach would need to be validated against independently labelled data so that precision, recall, false-positive rates and false-negative rates could be properly measured.

