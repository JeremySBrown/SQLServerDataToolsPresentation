CREATE VIEW [dbo].[vwOrgCoachSessionsMTD]
AS
SELECT   OrganizationID,
         TelestratedByUserID,
         Sum(Sessions) AS MTD
FROM     [vwSessionCountByOrgCoachMonthYear]
WHERE    [year] = Year(getdate())
         AND [Month] = Month(getdate())
GROUP BY OrganizationID, TelestratedByUserID;