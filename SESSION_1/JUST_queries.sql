-- Select policy number, quote value and quote date for all quotes created between the 1st of October of 2009 and the 3rd of May 2010.

SELECT tbl_policy.PolicyNumber, tbl_quote.QuoteValue, tbl_quote.QuoteDate 
FROM tbl_quote 
	INNER JOIN tbl_policy ON tbl_quote.PolicyID = tbl_policy.PolicyID 
		WHERE tbl_quote.DateCreated BETWEEN '2009-10-01' AND '2010-05-03';

-- Select name and full address of all accounts with more than 5 case created in 2011.

SELECT DISTINCT tbl_account.AccountName, tbl_account.AddressLine1
FROM tbl_account 
	INNER JOIN tbl_contact ON tbl_account.AccountID = tbl_contact.AccountID
	INNER JOIN tbl_policy ON tbl_contact.ContactID = tbl_policy.ContactID
		GROUP BY tbl_account.AccountName, tbl_account.AddressLine1
			HAVING COUNT(*) > 5;
		
-- Select Account Name and average quote value per year.