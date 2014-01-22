CREATE PROCEDURE [dbo].[aspnet_Membership_GetPasswordWithFormat]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256), @UpdateLastLoginActivityDate BIT, @CurrentTimeUtc DATETIME
AS
BEGIN
    DECLARE @IsLockedOut AS BIT;
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @Password AS NVARCHAR (128);
    DECLARE @PasswordSalt AS NVARCHAR (128);
    DECLARE @PasswordFormat AS INT;
    DECLARE @FailedPasswordAttemptCount AS INT;
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    DECLARE @IsApproved AS BIT;
    DECLARE @LastActivityDate AS DATETIME;
    DECLARE @LastLoginDate AS DATETIME;
    SELECT @UserId = NULL;
    SELECT @UserId = u.UserId,
           @IsLockedOut = m.IsLockedOut,
           @Password = Password,
           @PasswordFormat = PasswordFormat,
           @PasswordSalt = PasswordSalt,
           @FailedPasswordAttemptCount = FailedPasswordAttemptCount,
           @FailedPasswordAnswerAttemptCount = FailedPasswordAnswerAttemptCount,
           @IsApproved = IsApproved,
           @LastActivityDate = LastActivityDate,
           @LastLoginDate = LastLoginDate
    FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
    WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.ApplicationId = a.ApplicationId
           AND u.UserId = m.UserId
           AND LOWER(@UserName) = u.LoweredUserName;
    IF (@UserId IS NULL)
        RETURN 1;
    IF (@IsLockedOut = 1)
        RETURN 99;
    SELECT @Password,
           @PasswordFormat,
           @PasswordSalt,
           @FailedPasswordAttemptCount,
           @FailedPasswordAnswerAttemptCount,
           @IsApproved,
           @LastLoginDate,
           @LastActivityDate;
    IF (@UpdateLastLoginActivityDate = 1
        AND @IsApproved = 1)
        BEGIN
            UPDATE dbo.aspnet_Membership
            SET    LastLoginDate = @CurrentTimeUtc
            WHERE  UserId = @UserId;
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @CurrentTimeUtc
            WHERE  @UserId = UserId;
        END
    RETURN 0;
END