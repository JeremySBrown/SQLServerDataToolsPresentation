CREATE PROCEDURE [dbo].[aspnet_Membership_UpdateUserInfo]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256), @IsPasswordCorrect BIT, @UpdateLastLoginActivityDate BIT, @MaxInvalidPasswordAttempts INT, @PasswordAttemptWindow INT, @CurrentTimeUtc DATETIME, @LastLoginDate DATETIME, @LastActivityDate DATETIME
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    DECLARE @IsApproved AS BIT;
    DECLARE @IsLockedOut AS BIT;
    DECLARE @LastLockoutDate AS DATETIME;
    DECLARE @FailedPasswordAttemptCount AS INT;
    DECLARE @FailedPasswordAttemptWindowStart AS DATETIME;
    DECLARE @FailedPasswordAnswerAttemptCount AS INT;
    DECLARE @FailedPasswordAnswerAttemptWindowStart AS DATETIME;
    DECLARE @ErrorCode AS INT;
    SET @ErrorCode = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    SELECT @UserId = u.UserId,
           @IsApproved = m.IsApproved,
           @IsLockedOut = m.IsLockedOut,
           @LastLockoutDate = m.LastLockoutDate,
           @FailedPasswordAttemptCount = m.FailedPasswordAttemptCount,
           @FailedPasswordAttemptWindowStart = m.FailedPasswordAttemptWindowStart,
           @FailedPasswordAnswerAttemptCount = m.FailedPasswordAnswerAttemptCount,
           @FailedPasswordAnswerAttemptWindowStart = m.FailedPasswordAnswerAttemptWindowStart
    FROM   dbo.aspnet_Applications AS a, dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m WITH (UPDLOCK)
    WHERE  LOWER(@ApplicationName) = a.LoweredApplicationName
           AND u.ApplicationId = a.ApplicationId
           AND u.UserId = m.UserId
           AND LOWER(@UserName) = u.LoweredUserName;
    IF (@@rowcount = 0)
        BEGIN
            SET @ErrorCode = 1;
            GOTO Cleanup;
        END
    IF (@IsLockedOut = 1)
        BEGIN
            GOTO Cleanup;
        END
    IF (@IsPasswordCorrect = 0)
        BEGIN
            IF (@CurrentTimeUtc > DATEADD(minute, @PasswordAttemptWindow, @FailedPasswordAttemptWindowStart))
                BEGIN
                    SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc;
                    SET @FailedPasswordAttemptCount = 1;
                END
            ELSE
                BEGIN
                    SET @FailedPasswordAttemptWindowStart = @CurrentTimeUtc;
                    SET @FailedPasswordAttemptCount = @FailedPasswordAttemptCount + 1;
                END
            BEGIN
                IF (@FailedPasswordAttemptCount >= @MaxInvalidPasswordAttempts)
                    BEGIN
                        SET @IsLockedOut = 1;
                        SET @LastLockoutDate = @CurrentTimeUtc;
                    END
            END
        END
    ELSE
        BEGIN
            IF (@FailedPasswordAttemptCount > 0
                OR @FailedPasswordAnswerAttemptCount > 0)
                BEGIN
                    SET @FailedPasswordAttemptCount = 0;
                    SET @FailedPasswordAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
                    SET @FailedPasswordAnswerAttemptCount = 0;
                    SET @FailedPasswordAnswerAttemptWindowStart = CONVERT (DATETIME, '17540101', 112);
                    SET @LastLockoutDate = CONVERT (DATETIME, '17540101', 112);
                END
        END
    IF (@UpdateLastLoginActivityDate = 1)
        BEGIN
            UPDATE dbo.aspnet_Users
            SET    LastActivityDate = @LastActivityDate
            WHERE  @UserId = UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
            UPDATE dbo.aspnet_Membership
            SET    LastLoginDate = @LastLoginDate
            WHERE  UserId = @UserId;
            IF (@@ERROR <> 0)
                BEGIN
                    SET @ErrorCode = -1;
                    GOTO Cleanup;
                END
        END
    UPDATE dbo.aspnet_Membership
    SET    IsLockedOut                            = @IsLockedOut,
           LastLockoutDate                        = @LastLockoutDate,
           FailedPasswordAttemptCount             = @FailedPasswordAttemptCount,
           FailedPasswordAttemptWindowStart       = @FailedPasswordAttemptWindowStart,
           FailedPasswordAnswerAttemptCount       = @FailedPasswordAnswerAttemptCount,
           FailedPasswordAnswerAttemptWindowStart = @FailedPasswordAnswerAttemptWindowStart
    WHERE  @UserId = UserId;
    IF (@@ERROR <> 0)
        BEGIN
            SET @ErrorCode = -1;
            GOTO Cleanup;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN @ErrorCode;
    Cleanup:
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END