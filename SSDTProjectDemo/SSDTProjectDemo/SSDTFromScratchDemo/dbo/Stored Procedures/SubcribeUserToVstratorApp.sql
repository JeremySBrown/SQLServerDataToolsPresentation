CREATE PROCEDURE [dbo].[SubcribeUserToVstratorApp]
@VstratorAppID UNIQUEIDENTIFIER, @UserName NVARCHAR (255)
AS
DECLARE @UserID AS UNIQUEIDENTIFIER;
SELECT @UserID = up.ID
FROM   UserProfiles AS up
       INNER JOIN
       aspnet_users AS au
       ON up.MembershipUserID = au.UserId
WHERE  au.username = @UserName;
IF (@UserID IS NOT NULL
    AND NOT EXISTS (SELECT UserID,
                           VstratorAppID
                    FROM   VstratorAppSubscriptions
                    WHERE  UserID = @UserID
                           AND VstratorAppID = @VstratorAppID))
    BEGIN
        INSERT  INTO VstratorAppSubscriptions
        VALUES (@UserID, @VstratorAppID, 1, getdate());
    END
RETURN 0;