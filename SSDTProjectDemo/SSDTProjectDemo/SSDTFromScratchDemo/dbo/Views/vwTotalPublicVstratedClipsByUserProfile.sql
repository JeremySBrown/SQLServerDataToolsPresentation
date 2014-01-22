CREATE VIEW [dbo].[vwTotalPublicVstratedClipsByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Count(sv.SessionVideoID) AS PublicVstratedClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         SessionVideos AS sv
         ON up.id = sv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
         AND (sv.IsPrivate = 0
              OR sv.IsPrivate IS NULL)
         AND sv.Deleted = 0
GROUP BY up.id;