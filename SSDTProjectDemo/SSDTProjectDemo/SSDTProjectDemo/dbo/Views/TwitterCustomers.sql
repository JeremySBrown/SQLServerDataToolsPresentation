CREATE VIEW [dbo].[TwitterCustomers]
	AS SELECT c.FirstName, c.LastName, ia.Address [TwitterUserName]
	FROM [Customers] c
	join [InternetAddresses] ia on c.Id = ia.CustomerId
	where ia.AddressType = 4