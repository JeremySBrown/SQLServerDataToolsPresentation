CREATE VIEW [dbo].[vwUserProfileSummary]
AS
SELECT up.ID,
       up.FirstName,
       up.LastName,
       up.EmailAddress,
       up.ProfilePicture,
       up.ProfileText,
       up.City,
       up.StateProvince,
       IsNull(tc.TotalClips, 0) AS TotalClips,
       IsNull(tvc.TotalVstratedClips, 0) AS TotalVstratedClips,
       IsNull(nc.NewClips, 0) AS NewClips,
       IsNull(nvc.NewVstratedClips, 0) AS NewVstratedClips,
       IsNull(followers.Followers, 0) AS TotalFollowers,
       ISNULL(followings.Following, 0) AS TotalFollowing
FROM   UserProfiles AS up
       LEFT OUTER JOIN
       vwTotalClipsByUserProfile AS tc
       ON up.ID = tc.UserProfileID
       LEFT OUTER JOIN
       vwTotalVstratedClipsByUserProfile AS tvc
       ON up.id = tvc.UserProfileID
       LEFT OUTER JOIN
       vwNewClipsByUserProfile AS nc
       ON up.ID = nc.UserProfileID
       LEFT OUTER JOIN
       vwNewVstratedClipsByUserProfile AS nvc
       ON up.ID = nvc.UserProfileID
       LEFT OUTER JOIN
       vwTotalFollowersByUserProfile AS followers
       ON up.ID = followers.UserID
       LEFT OUTER JOIN
       vwTotalFollowingByUserProfile AS followings
       ON up.ID = followings.UserID
WHERE  up.ID <> '00000000-0000-0000-0000-000000000000';