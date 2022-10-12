INSERT INTO dbo.tbl_account (AccountName, AddressLine1, Town, Postcode)
	VALUES
		('LUCASC', '109 - ARNOLD ROAD', 'BRASIL', '37900'),
		('ALLANS', '37 - ARNOLD ROAD', 'LONDON', 'N154JF'),
		('MAISAG', '37 - ARNOLD ROAD', 'LONDON', 'N154JF'),
		('FILIPIC', '76-78 - GOODHALL STREET', 'LONDON', 'NW106TF'),
		('MARCON', '76-78 - GOODHALL STREET', 'LONDON', 'NW106TF'),
		('NIKOLAI', '2 - TUFNEL PARK', 'LONDON', 'N70DP'),
		('ETHAN', '23 - OSLO', 'LONDON', 'EC15GH'),
		('DREW', '25 - OSLO', 'LONDON', 'EC14DK'),
		('JASMINE', '89 - WEST', 'LONDON', 'W32TC');

INSERT INTO dbo.tbl_contact (Firstname, Lastname, EmailAddress, TelephoneNumber, AccountID)
	VALUES
		('Lucas', 'Conde Stocco', 'lucascondestocco@hotmail.com', '123123123123', 1),
		('Allan', 'Stocco Rezende', 'allanstocco@hotmail.com', '07460031651', 2),
		('Maisa', 'Guiraldelli de Souza', 'maisaguiraldelli@gmail.com', '123123123123', 3),
		('Filipi', 'Catarino', 'filipecatarino@gmail.com', '321321321321', 4),
		('Marcon', 'Pacco', 'marcompacco@hotmail.com', '32323212123', 5),
		('Nikolas', 'Constante', 'nicolasconst@yahoo.com', '0324354234', 6),
		('Ethan', 'Cross', 'ethancross@outlook.com', '666555444333', 7),
		('Drew', 'Goodman', 'ethangoodman@hotmail.com', '321123333222', 8),
		('Jasmine', 'Lorem', 'jass@uol.com', '000992228888', 9);

INSERT INTO dbo.tbl_policy (PolicyNumber, PolicyDate, ContactID)
	VALUES 
		(106, '2010-01-06', 1),
		(1500, '2010-03-06', 2),
		(3784, '2009-10-1', 3),
		(3, '2010-02-23', 4),
		(67, '2009-12-20', 5),
		(89, '2009-11-13', 6),
		(412, '2010-01-29', 7),
		(107, '2010-04-09', 8),
		(1011, '2010-06-01', 9),
		(106, '2011-01-06', 2),
		(108, '2011-02-06', 2),
		(110, '2011-03-06', 2),
		(111, '2011-04-06', 2),
		(112, '2011-05-06', 2),
		(113, '2011-06-06', 1);

INSERT INTO dbo.tbl_quote (QuoteNumber, QuoteDate, QuoteValue, PolicyID)
	VALUES
		(15, '2009-11-13', 100, 1),
		(16, '2010-01-29', 200, 1),
		(17, '2010-04-09', 100, 2),
		(18, '2010-06-01', 100, 1),
		(19, '2010-06-01', 100, 3),
		(20, '2010-06-01', 400, 4),
		(21, '2010-06-01', 300, 1),
		(22, '2010-06-01', 800, 2),
		(32, '2010-06-01', 300, 2),
		(44, '2010-06-01', 1665, 3),
		(11, '2010-06-01', 200, 3),
		(10, '2010-06-01', 1500, 3);



