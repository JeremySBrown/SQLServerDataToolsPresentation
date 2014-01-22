CREATE VIEW [dbo].[vwVideoCountByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Sum(CASE WHEN cv.ClipVideoID IS NULL THEN 0 ELSE 1 END) AS TotalClips,
         Sum(CASE WHEN sv.SessionVideoID IS NULL THEN 0 ELSE 1 END) AS TotalVstratedClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         ClipVideos AS cv
         ON up.ID = cv.OwnerID
         LEFT OUTER JOIN
         SessionVideos AS sv
         ON up.id = sv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
GROUP BY up.id;