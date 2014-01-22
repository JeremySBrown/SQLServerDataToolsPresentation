CREATE PROCEDURE [dbo].[aspnet_Membership_GetUserByName]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256), @CurrentTimeUtc DATETIME, @UpdateLastActivity BIT=0
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    IF (@UpdateLastActivity = 1)
        BEGIN
            SELECT TOP 1 @UserId = u.UserId
            FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
            WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
                   AND u.ApplicationId = a.ApplicationId
                   AND LOWER(@UserName) = u.LoweredUserName
                   AND u.UserId = m.UserId;
            IF (@@ROWCOUNT = 0)
                RETURN -1;
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CurrentTimeUtc
            WHERE  @UserId = UserId;
            SELECT m.Email,
                   m.PasswordQuestion,
                   m.Comment,
                   m.IsApproved,
                   m.CreateDate,
                   m.LastLoginDate,
                   u.LastActivityDate,
                   m.LastPasswordChangedDate,
                   u.UserId,
                   m.IsLockedOut,
                   m.LastLockoutDate
            FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
            WHERE  @UserId = u.UserId
                   AND u.UserId = m.UserId;
        END
    ELSE
        BEGIN
            SELECT TOP 1 m.Email,
                         m.PasswordQuestion,
                         m.Comment,
                         m.IsApproved,
                         m.CreateDate,
                         m.LastLoginDate,
                         u.LastActivityDate,
                         m.LastPasswordChangedDate,
                         u.UserId,
                         m.IsLockedOut,
                         m.LastLockoutDate
            FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
            WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
                   AND u.ApplicationId = a.ApplicationId
                   AND LOWER(@UserName) = u.LoweredUserName
                   AND u.UserId = m.UserId;
            IF (@@ROWCOUNT = 0)
                RETURN -1;
        END
    RETURN 0;
END