CREATE VIEW [dbo].[vwUserConnectionInfo]
AS
SELECT up.ID AS UserProfileID,
       up.FirstName,
       up.LastName,
       up.EmailAddress,
       up.ProfilePicture,
       up.ProfileText,
       up.City,
       up.StateProvince,
       vc.TotalClips,
       vc.TotalVstratedClips,
       IsNull(tFollowing.Following, 0) AS Following,
       IsNull(tFollowers.Followers, 0) AS Followers
FROM   UserProfiles AS up
       INNER JOIN
       vwVideoCountByUserProfile AS vc
       ON up.ID = vc.UserProfileID
       LEFT OUTER JOIN
       vwTotalFollowingByUserProfile AS tFollowing
       ON tFollowing.UserID = up.ID
       LEFT OUTER JOIN
       vwTotalFollowersByUserProfile AS tFollowers
       ON tFollowers.UserID = up.ID;