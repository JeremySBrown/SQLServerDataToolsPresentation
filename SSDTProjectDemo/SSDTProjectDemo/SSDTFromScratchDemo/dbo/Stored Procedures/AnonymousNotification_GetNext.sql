CREATE PROCEDURE [dbo].[AnonymousNotification_GetNext]
@AppUserId NVARCHAR (75), @AppId UNIQUEIDENTIFIER
AS
DECLARE @AnonUserId AS INT;
DECLARE @InstallDate AS DATETIME2;
DECLARE @DaysSinceInstall AS INT;
SELECT @AnonUserId = ID,
       @InstallDate = DateCreated,
       @DaysSinceInstall = DateDiff(dd, @InstallDate, getdate())
FROM   [dbo].[AnonymousAppUsers]
WHERE  AppUserID = @AppUserId
       AND VstratorAppID = @AppID;
IF @AnonUserId IS NULL
    BEGIN
        INSERT  INTO [dbo].[AnonymousAppUsers] (AppUserID, VstratorAppID)
        VALUES                                (@AppUserID, @AppID);
        SET @AnonUserId = @@Identity;
        SET @InstallDate = getdate();
        SET @DaysSinceInstall = 0;
    END
SELECT   TOP (1) app.*
FROM     [dbo].[AppNotifications] AS app
         LEFT OUTER JOIN
         [dbo].[AnonymousNotifications] AS anon
         ON app.ID = anon.AppNotificationID
WHERE    app.VstratorAppID = @AppID
         AND NOT app.ID IN (SELECT AppNotificationID
                            FROM   [dbo].[AnonymousNotifications]
                            WHERE  [AnonymousAppUserID] = @AnonUserID)
         AND MinimumInterval <= @DaysSinceInstall
ORDER BY MinimumInterval;
RETURN 0;