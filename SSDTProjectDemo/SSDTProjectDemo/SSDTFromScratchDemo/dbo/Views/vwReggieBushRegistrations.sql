CREATE VIEW [dbo].[vwReggieBushRegistrations]
AS
SELECT   CONVERT (NVARCHAR (20), DateCreated, 101) AS RegistrationDate,
         count(VstratorAppID) AS Registrations
FROM     [dbo].[VstratorAppSubscriptions]
WHERE    vstratorappid = '5249FF55-5084-4662-AA4D-D99BDF5E7415'
         AND datecreated > '9/25/2012'
GROUP BY CONVERT (NVARCHAR (20), DateCreated, 101);