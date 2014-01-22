CREATE VIEW [dbo].[vwTotalPublicClipsByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Count(cv.ClipVideoID) AS PublicClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         ClipVideos AS cv
         ON up.id = cv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
         AND (cv.IsPrivate = 0
              OR cv.IsPrivate IS NULL)
         AND cv.Deleted = 0
GROUP BY up.id;