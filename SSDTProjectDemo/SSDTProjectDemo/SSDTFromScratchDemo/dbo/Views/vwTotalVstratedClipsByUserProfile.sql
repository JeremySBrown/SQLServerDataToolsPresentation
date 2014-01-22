CREATE VIEW [dbo].[vwTotalVstratedClipsByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Count(sv.SessionVideoID) AS TotalVstratedClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         SessionVideos AS sv
         ON up.id = sv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
GROUP BY up.id;