CREATE PROCEDURE [dbo].[aspnet_Users_DeleteUser]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256), @TablesToDeleteFrom INT, @NumTablesDeletedFrom INT OUTPUT
AS
BEGIN
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @NumTablesDeletedFrom = 0;
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    ELSE
        SET @TranStarted = 0;
    DECLARE @ErrorCode AS INT;
    DECLARE @RowCount AS INT;
    SET @ErrorCode = 0;
    SET @RowCount = 0;
    SELECT @UserId = u.UserId
    FROM   dbo.aspnet_Users AS u, dbo.aspnet_Applications AS a
    WHERE  u.LoweredUserName = LOWER(@UserName)
           AND u.ApplicationId = a.ApplicationId
           AND LOWER(@ApplicationName) = a.LoweredApplicationName;
    IF (@UserId IS NULL)
        BEGIN
            GOTO Cleanup;
        END
    IF ((@TablesToDeleteFrom & 1) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_MembershipUsers')
                            AND (type = 'V'))))
        BEGIN
            DELETE dbo.aspnet_Membership
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF ((@TablesToDeleteFrom & 2) <> 0
        AND (EXISTS (SELECT name
                     FROM   sysobjects
                     WHERE  (name = N'vw_aspnet_UsersInRoles')
                            AND (type = 'V'))))
        BEGIN
            DELETE dbo.aspnet_UsersInRoles
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF ((@TablesToDeleteFrom & 1) <> 0
        AND (@TablesToDeleteFrom & 2) <> 0
        AND (@TablesToDeleteFrom & 4) <> 0
        AND (@TablesToDeleteFrom & 8) <> 0
        AND (EXISTS (SELECT UserId
                     FROM   dbo.aspnet_Users
                     WHERE  @UserId = UserId)))
        BEGIN
            DELETE dbo.aspnet_Users
            WHERE  @UserId = UserId;
            SELECT @ErrorCode = @@ERROR,
                   @RowCount = @@ROWCOUNT;
            IF (@ErrorCode <> 0)
                GOTO Cleanup;
            IF (@RowCount <> 0)
                SELECT @NumTablesDeletedFrom = @NumTablesDeletedFrom + 1;
        END
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            COMMIT TRANSACTION;
        END
    RETURN 0;
    Cleanup:
    SET @NumTablesDeletedFrom = 0;
    IF (@TranStarted = 1)
        BEGIN
            SET @TranStarted = 0;
            ROLLBACK;
        END
    RETURN @ErrorCode;
END