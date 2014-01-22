CREATE VIEW [dbo].[vwTotalFollowersByUserProfile]
AS
SELECT   ToUserID AS UserID,
         count(*) AS Followers
FROM     [dbo].[UserConnections]
WHERE    ConnectionStatus = 2
         AND Active = 1
GROUP BY ToUserId;