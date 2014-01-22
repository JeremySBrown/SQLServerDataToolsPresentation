CREATE VIEW [dbo].[vwOrgCoachSessionsYTD]
AS
SELECT   OrganizationID,
         TelestratedByUserID,
         Sum(Sessions) AS YTD
FROM     [vwSessionCountByOrgCoachMonthYear]
WHERE    [year] = Year(getdate())
GROUP BY OrganizationID, TelestratedByUserID;