CREATE VIEW [dbo].[vwTotalFollowingByUserProfile]
AS
SELECT   FromUserID AS [UserID],
         count(*) AS Following
FROM     [dbo].[UserConnections]
WHERE    ConnectionStatus = 2
         AND Active = 1
GROUP BY FromUserId;