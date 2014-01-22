CREATE VIEW [dbo].[vwNewClipsByUserProfile]
AS
SELECT   up.ID AS UserProfileID,
         Sum(CASE WHEN cv.ClipVideoID IS NULL THEN 0 ELSE 1 END) AS NewClips
FROM     UserProfiles AS up
         LEFT OUTER JOIN
         ClipVideos AS cv
         ON up.ID = cv.OwnerID
WHERE    up.id <> '00000000-0000-0000-0000-000000000000'
         AND DATEDIFF(dd, cv.ClipDate, getdate()) <= 14
GROUP BY up.id;