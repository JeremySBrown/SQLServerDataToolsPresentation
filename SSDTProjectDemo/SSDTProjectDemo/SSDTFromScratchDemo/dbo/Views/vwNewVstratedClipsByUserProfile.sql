CREATE VIEW [dbo].[vwNewVstratedClipsByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Sum(CASE WHEN sv.SessionVideoID IS NULL THEN 0 ELSE 1 END) AS NewVstratedClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         SessionVideos AS sv
         ON up.id = sv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
         AND DATEDIFF(dd, sv.TelestrationDate, getdate()) <= 14
GROUP BY up.id;