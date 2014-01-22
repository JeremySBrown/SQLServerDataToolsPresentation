CREATE VIEW [dbo].[vwTotalClipsByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Count(cv.ClipVideoID) AS TotalClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         ClipVideos AS cv
         ON up.id = cv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
GROUP BY up.id;