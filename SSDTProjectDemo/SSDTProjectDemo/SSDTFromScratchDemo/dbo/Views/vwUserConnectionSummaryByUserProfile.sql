CREATE VIEW [dbo].[vwUserConnectionSummaryByUserProfile]
AS
SELECT up.ID,
       IsNull(tFollowing.Following, 0) AS Following,
       IsNull(tFollowers.Followers, 0) AS Followers
FROM   UserProfiles AS up
       LEFT OUTER JOIN
       vwTotalFollowingByUserProfile AS tFollowing
       ON tFollowing.UserID = up.ID
       LEFT OUTER JOIN
       vwTotalFollowersByUserProfile AS tFollowers
       ON tFollowers.UserID = up.ID
WHERE  up.ID <> '00000000-0000-0000-0000-000000000000';