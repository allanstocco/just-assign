-- 1 Select policy number, quote value and quote date for all quotes created between the 1st of October of 2009 and the 3rd of May 2010.
SELECT tbl_policy.PolicyNumber, tbl_quote.QuoteValue, tbl_quote.QuoteDate 
FROM tbl_quote 
	INNER JOIN tbl_policy ON tbl_quote.PolicyID = tbl_policy.PolicyID 
		WHERE tbl_quote.DateCreated BETWEEN '2009-10-01' AND '2010-05-03';


--------------------------------------------------------------------------------
-- 2 Select name and full address of all accounts with more than 5 case created in 2011.
SELECT DISTINCT tbl_account.AccountName, tbl_account.AddressLine1, tbl_account.AddressLine2, tbl_account.AddressLine3
FROM tbl_account 
	INNER JOIN tbl_contact ON tbl_account.AccountID = tbl_contact.AccountID
	INNER JOIN tbl_policy ON tbl_contact.ContactID = tbl_policy.ContactID
		WHERE datepart(year, tbl_policy.DateCreated) = 2011 
			GROUP BY tbl_account.AccountName, tbl_account.AddressLine1, tbl_account.AddressLine2, tbl_account.AddressLine3
				HAVING COUNT(*) > 5;


--------------------------------------------------------------------------------
-- 3 Select Account Name and average quote value per year.

-- SOLUTION 1
SELECT DISTINCT tbl_account.AccountName, AVG(tbl_quote.QuoteValue)
FROM tbl_account
	INNER JOIN tbl_contact ON tbl_account.AccountID = tbl_contact.AccountID
	INNER JOIN tbl_policy ON tbl_contact.ContactID = tbl_policy.ContactID
	INNER JOIN tbl_quote ON tbl_policy.PolicyID = tbl_quote.PolicyID
		WHERE  datepart(year, tbl_quote.QuoteDate) = 2010
			GROUP BY tbl_account.AccountName;


--OR	WHERE tbl_quote.QuoteDate >= '2010-01-01' AND tbl_quote.QuoteDate < '2011-01-01' GROUP BY tbl_account.AccountName;

-- OR
-- SOLUTION 2 
SELECT tbl_account.AccountName, YEAR(tbl_quote.QuoteDate) AS QUOTES_YEAR, AVG(tbl_quote.QuoteValue) AS AVG_QUOTE_VALUE
FROM tbl_account
	INNER JOIN tbl_contact ON tbl_account.AccountID = tbl_contact.AccountID
	INNER JOIN tbl_policy ON tbl_contact.ContactID = tbl_policy.ContactID
	INNER JOIN tbl_quote ON tbl_policy.PolicyID = tbl_quote.PolicyID
		GROUP BY tbl_account.AccountName, YEAR(tbl_quote.QuoteDate);
--------------------------------------------------------------------------------

-- 4 Select account name, contact last name, case number, quote number, quote date and quote value for the third largest quote ever created for each of the accounts in the EC1 area

-- This one was quite tricky so I tried to approach a solution in many ways. These two following was the most approx I reached

-- SOLUTION 1
SELECT
	QUOTE.PolicyID,
	QUOTE.QuoteNumber, 
	QUOTE.QuoteDate, 
	QUOTE.QuoteValue,
	tbl_account.AccountName,
	tbl_contact.Lastname
	FROM
		(SELECT		
			tbl_quote.PolicyID, 
			tbl_quote.QuoteNumber, 
			tbl_quote.QuoteDate, 
			tbl_quote.QuoteValue, 
			RANK() OVER (PARTITION BY tbl_quote.PolicyID 
				ORDER BY tbl_quote.QuoteValue DESC) 
					AS RANKING
			FROM tbl_quote) QUOTE
		INNER JOIN tbl_policy ON tbl_policy.PolicyID = QUOTE.PolicyID
		INNER JOIN tbl_contact ON tbl_contact.ContactID = tbl_policy.ContactID
		INNER JOIN tbl_account ON tbl_account.AccountID = tbl_contact.AccountID
			WHERE QUOTE.RANKING = 3 AND tbl_account.AddressLine1 LIKE '%EC1%'


		
-- SOLUTION 2
SELECT 
	tbl_account.AccountName, 
	tbl_contact.Lastname, 
	tbl_policy.PolicyID, 
	tbl_policy.PolicyNumber,
	(SELECT tbl_quote.QuoteValue FROM tbl_quote
		WHERE PolicyID = tbl_policy.PolicyID
			ORDER BY tbl_quote.QuoteValue DESC
				OFFSET 2 ROWS
					FETCH NEXT 1 ROWS ONLY) AS THIRD_HIGHEST
FROM tbl_account
	INNER JOIN tbl_contact ON tbl_account.AccountID = tbl_contact.AccountID
	INNER JOIN tbl_policy ON tbl_contact.ContactID = tbl_policy.ContactID
	INNER JOIN tbl_quote ON tbl_policy.PolicyID = tbl_quote.PolicyID
		WHERE tbl_account.AddressLine1 LIKE '%EC1%'
			GROUP BY tbl_account.AccountName, tbl_contact.Lastname, tbl_policy.PolicyNumber, tbl_policy.PolicyID
				ORDER BY tbl_account.AccountName DESC


--------------------------------------------------------------------------------

-- 5 Select first name and last name for each contact working in accounts in the EC1 area and the date of the most recent and the oldest quote
SELECT tbl_contact.Firstname, tbl_contact.Lastname, tbl_account.AddressLine1, RECENT_QUOTE, OLDEST_QUOTE
	FROM tbl_account
		INNER JOIN tbl_contact ON tbl_contact.AccountID = tbl_account.AccountID
		INNER JOIN tbl_policy ON tbl_policy.ContactID = tbl_policy.ContactID
		INNER JOIN (SELECT tbl_quote.PolicyID, MAX(tbl_quote.QuoteDate) AS RECENT_QUOTE, MIN(tbl_quote.QuoteDate) AS OLDEST_QUOTE
			FROM tbl_quote
				GROUP BY tbl_quote.PolicyID) QUERI ON QUERI.PolicyID = tbl_policy.PolicyID
					AND tbl_policy.ContactID = tbl_contact.ContactID
						WHERE tbl_account.AddressLine1 LIKE '%EC1%'