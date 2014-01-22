﻿CREATE PROCEDURE [dbo].[aspnet_Membership_ChangePasswordQuestionAndAnswer]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256), @NewPasswordQuestion NVARCHAR (256), @NewPasswordAnswer NVARCHAR (128)
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a
    WHERE  LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.UserId = m.UserId;
    IF (@UserId IS NULL)
        BEGIN
            RETURN (1);
        END
    UPDATE dbo.aspnet_Membership
    SET    PasswordQuestion = @NewPasswordQuestion,
           PasswordAnswer   = @NewPasswordAnswer
    WHERE  UserId = @UserId;
    RETURN (0);
END