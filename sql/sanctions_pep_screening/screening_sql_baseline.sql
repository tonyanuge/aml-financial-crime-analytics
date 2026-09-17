/* =====================================================================
   Sanctions and PEP Screening: Part 1, SQL matching baseline
   Engine: Microsoft SQL Server (T-SQL)

   Purpose: screen the customer base against the sanctions and PEP
   watchlist using exact and simple string matching, and measure how many
   candidates each rule returns. This establishes the baseline and, by
   design, exposes its weakness: string equality cannot catch spelling and
   transliteration variants (for example Okafor vs Okafour, Muller vs
   Mueller), which motivates the fuzzy-matching stage in Part 2.

   Sources:
     dbo.sample_customers (full_name, country)
     dbo.watchlist        (listed_name, watchlist_type, country, alias_1, alias_2)
   ===================================================================== */


/* Exact full-name match: customer full_name identical to a listed_name.
   Highest precision, but misses every variant the watchlist plants. This
   is the strict baseline: record the hit count. */

-- Solution:
SELECT 
    customer_id,
    full_name
FROM sample_customers c
INNER JOIN dbo.watchlist w 
ON c.full_name = w.listed_name;

/* Surname-only candidates: match on surname alone.
   Surname is extracted with RIGHT / CHARINDEX / REVERSE (last token of the
   name). Expected to return a high volume dominated by coincidental
   same-surname collisions across the population. Record the count. */

-- Solution:

WITH exact_match_cust AS(
SELECT
	customer_id,
    full_name,
	country,
    RIGHT(
        full_name,
        CHARINDEX(' ', REVERSE(full_name)) - 1
    ) AS cust_surname
FROM dbo.sample_customers),


exact_match_List AS(
SELECT
	watchlist_id,
    listed_name,
	country,
    RIGHT(
        listed_name,
        CHARINDEX(' ', REVERSE(listed_name)) - 1
    ) AS list_surname
FROM dbo.watchlist)
SELECT  
	customer_id,
	watchlist_id,
    c.full_name,
    c.cust_surname,
	w.listed_name,
	w.list_surname,
	c.country,
	w.country
FROM exact_match_cust c join exact_match_list w
ON c.cust_surname = w.list_surname


/* Surname plus country candidates: add country as a pre-filter to the
   surname match. Reduces false positives, but note the trade-off: country
   is a secondary identifier, so pre-filtering on it can suppress a genuine
   hit where recorded country differs from the listing. Record the count. */

-- Solution:

WITH exact_match_cust AS(
SELECT
	customer_id,
    full_name,
	country,
    RIGHT(
        full_name,
        CHARINDEX(' ', REVERSE(full_name)) - 1
    ) AS cust_surname
FROM dbo.sample_customers),


exact_match_List AS(
SELECT
	watchlist_id,
    listed_name,
	country,
    RIGHT(
        listed_name,
        CHARINDEX(' ', REVERSE(listed_name)) - 1
    ) AS list_surname
FROM dbo.watchlist)
SELECT  
	customer_id,
	watchlist_id,
    c.full_name,
    c.cust_surname,
	w.listed_name,
	w.list_surname,
	c.country,
	w.country
FROM exact_match_cust c join exact_match_list w
ON c.cust_surname = w.list_surname
AND
c.country = w.country



/* Alias awareness: the watchlist carries alias_1 and alias_2 because listed
   parties operate under alternate names. Exact matching against listed_name
   alone will miss alias hits. Either extend the match to the alias columns
   here, or note that alias and variant handling is covered by the fuzzy
   matching in Part 2. */



/* Baseline result to record for the write-up:
     - exact full-name match count
     - surname-only candidate count
     - surname plus country candidate count
   Then confirm which planted variants the baseline MISSED (the misspelled
   and transliterated names), since that documented gap is what makes the
   Part 2 fuzzy approach measurable. */
