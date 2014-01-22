CREATE PROCEDURE [dbo].[GetUserConnectionInfoForUserProfile]
@UserName NVARCHAR (255), @Active BIT, @ConnectionStatus INT
AS
SELECT uc.ID,
       uc.ConnectionStatus,
       vwUCI.*
FROM   UserConnections AS uc
       INNER JOIN
       UserProfiles AS up
       ON uc.FromUserID = up.ID
       INNER JOIN
       aspnet_Users AS aspU
       ON up.MembershipUserID = aspU.UserId
       INNER JOIN
       vwUserConnectionInfo AS vwUCI
       ON uc.ToUserID = vwUCI.UserProfileID
WHERE  aspU.UserName = @UserName
       AND (@Active IS NULL
            OR uc.Active = @Active)
       AND (@ConnectionStatus IS NULL
            OR uc.ConnectionStatus = @ConnectionStatus);
RETURN 0;