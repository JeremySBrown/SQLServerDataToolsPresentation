CREATE VIEW [dbo].[vwSessionCountByOrgCoachMonthYear]
AS
SELECT   OrganizationID,
         TelestratedByUserID,
         Year(TelestrationDate) AS [Year],
         Month(TelestrationDate) AS [Month],
         Count(TelestratedByUserID) AS [Sessions]
FROM     SessionVideos
WHERE    organizationid IS NOT NULL
         AND Telestratedbyuserid IS NOT NULL
         AND TelestratedByUserID <> '00000000-0000-0000-0000-000000000000'
GROUP BY OrganizationID, TelestratedByUserID, Year(TelestrationDate), Month(TelestrationDate);