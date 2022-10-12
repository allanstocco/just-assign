DROP TABLE IF EXISTS tbl_quote;

DROP TABLE IF EXISTS tbl_policy;

DROP TABLE IF EXISTS tbl_contact;

DROP TABLE IF EXISTS tbl_account;

CREATE TABLE tbl_account (
	AccountID  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	AccountName VARCHAR(255),
	AddressLine1 VARCHAR(255),
	AddressLine2 VARCHAR(255),
	AddressLine3 VARCHAR(255),
	Town VARCHAR(255),
	Postcode VARCHAR(255),
	DateCreated DATE NOT NULL DEFAULT(GETDATE()) ,
	DateLastUpdated DATE NOT NULL DEFAULT(GETDATE()),
	
)

CREATE TABLE tbl_contact (
	ContactID  INT  IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Firstname  VARCHAR(255),
	Lastname  VARCHAR(255),
	EmailAddress  VARCHAR(255),
	TelephoneNumber  VARCHAR(255),
	DateCreated DATE NOT NULL DEFAULT(GETDATE()) ,
	DateLastUpdated DATE NOT NULL DEFAULT(GETDATE()) ,

	
	AccountID INT 
		REFERENCES tbl_account (AccountID)
			ON DELETE CASCADE
)

CREATE TABLE tbl_policy (
	PolicyID INT  IDENTITY(1,1) NOT NULL PRIMARY KEY,
	PolicyNumber INT,
	PolicyDate DATE,
	DateCreated DATE NOT NULL DEFAULT(GETDATE()),
	DateLastUpdated DATE NOT NULL DEFAULT(GETDATE()),

	
	ContactID INT
		REFERENCES tbl_contact (ContactID)
			ON DELETE CASCADE
)

CREATE TABLE tbl_quote (
	QuoteID  INT IDENTITY(1,1)  NOT NULL  PRIMARY KEY,
	QuoteNumber INT,
	QuoteDate DATE,
	QuoteValue INT,
	DateCreated DATE NOT NULL DEFAULT(GETDATE()),
	DateLastUpdated DATE NOT NULL DEFAULT(GETDATE()),

	PolicyID INT 
		REFERENCES tbl_policy (PolicyID)
			ON DELETE CASCADE
)

