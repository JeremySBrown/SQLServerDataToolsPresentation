﻿CREATE PROCEDURE [dbo].[aspnet_Membership_SetPassword]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256), @NewPassword NVARCHAR (128), @PasswordSalt NVARCHAR (128), @CurrentTimeUtc DATETIME, @PasswordFormat INT=0
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a, dbo.aspnet_Membership AS m
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        RETURN (1);
    UPDATE dbo.aspnet_Membership
    SET    Password                = @NewPassword,
           PasswordFormat          = @PasswordFormat,
           PasswordSalt            = @PasswordSalt,
           LastPasswordChangedDate = @CurrentTimeUtc
    WHERE  @UserId = UserId;
    RETURN (0);
END