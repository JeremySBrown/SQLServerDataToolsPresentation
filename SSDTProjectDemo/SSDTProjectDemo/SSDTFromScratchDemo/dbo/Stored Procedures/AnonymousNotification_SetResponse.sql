CREATE PROCEDURE [dbo].[AnonymousNotification_SetResponse]
@AppUserId NVARCHAR (75), @AppId UNIQUEIDENTIFIER, @AppNotificationId UNIQUEIDENTIFIER
AS
DECLARE @AnonUserId AS INT;
SELECT @AnonUserId = ID
FROM   [dbo].[AnonymousAppUsers]
WHERE  AppUserID = @AppUserId
       AND VstratorAppID = @AppID;
IF NOT @AnonUserId IS NULL
   AND NOT EXISTS (SELECT ResponseDate
                   FROM   [dbo].[AnonymousNotifications]
                   WHERE  [AnonymousAppUserID] = @AnonUserId
                          AND [AppNotificationID] = @AppNotificationId)
    BEGIN
        INSERT  INTO [dbo].[AnonymousNotifications] ([AnonymousAppUserID], [AppNotificationID])
        VALUES                                     (@AnonUserId, @AppNotificationId);
    END
RETURN 0;