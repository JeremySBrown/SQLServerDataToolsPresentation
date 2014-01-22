CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_AddUsersToRoles]
@ApplicationName NVARCHAR (256), @UserNames NVARCHAR (4000), @RoleNames NVARCHAR (4000), @CurrentTimeUtc DATETIME
AS
BEGIN
    DECLARE @AppId AS UNIQUEIDENTIFIER;
    SELECT @AppId = NULL;
    SELECT @AppId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@AppId IS NULL)
        RETURN (2);
    DECLARE @TranStarted AS BIT;
    SET @TranStarted = 0;
    IF (@@TRANCOUNT = 0)
        BEGIN
            BEGIN TRANSACTION;
            SET @TranStarted = 1;
        END
    DECLARE @tbNames TABLE (
        Name NVARCHAR (256) NOT NULL PRIMARY KEY);
    DECLARE @tbRoles TABLE (
        RoleId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY);
    DECLARE @tbUsers TABLE (
        UserId UNIQUEIDENTIFIER NOT NULL PRIMARY KEY);
    DECLARE @Num AS INT;
    DECLARE @Pos AS INT;
    DECLARE @NextPos AS INT;
    DECLARE @Name AS NVARCHAR (256);
    SET @Num = 0;
    SET @Pos = 1;
    WHILE (@Pos <= LEN(@RoleNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @RoleNames, @Pos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@RoleNames) + 1;
            SELECT @Name = RTRIM(LTRIM(SUBSTRING(@RoleNames, @Pos, @NextPos - @Pos)));
            SELECT @Pos = @NextPos + 1;
            INSERT  INTO @tbNames
            VALUES (@Name);
            SET @Num = @Num + 1;
        END
    INSERT INTO @tbRoles
    SELECT RoleId
    FROM   dbo.aspnet_Roles AS ar, @tbNames AS t
    WHERE  LOWER(t.Name) = ar.LoweredRoleName
           AND ar.ApplicationId = @AppId;
    IF (@@ROWCOUNT <> @Num)
        BEGIN
            SELECT TOP 1 Name
            FROM   @tbNames
            WHERE  LOWER(Name) NOT IN (SELECT ar.LoweredRoleName
                                       FROM   dbo.aspnet_Roles AS ar, @tbRoles AS r
                                       WHERE  r.RoleId = ar.RoleId);
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (2);
        END
    DELETE @tbNames
    WHERE  1 = 1;
    SET @Num = 0;
    SET @Pos = 1;
    WHILE (@Pos <= LEN(@UserNames))
        BEGIN
            SELECT @NextPos = CHARINDEX(N',', @UserNames, @Pos);
            IF (@NextPos = 0
                OR @NextPos IS NULL)
                SELECT @NextPos = LEN(@UserNames) + 1;
            SELECT @Name = RTRIM(LTRIM(SUBSTRING(@UserNames, @Pos, @NextPos - @Pos)));
            SELECT @Pos = @NextPos + 1;
            INSERT  INTO @tbNames
            VALUES (@Name);
            SET @Num = @Num + 1;
        END
    INSERT INTO @tbUsers
    SELECT UserId
    FROM   dbo.aspnet_Users AS ar, @tbNames AS t
    WHERE  LOWER(t.Name) = ar.LoweredUserName
           AND ar.ApplicationId = @AppId;
    IF (@@ROWCOUNT <> @Num)
        BEGIN
            DELETE @tbNames
            WHERE  LOWER(Name) IN (SELECT LoweredUserName
                                   FROM   dbo.aspnet_Users AS au, @tbUsers AS u
                                   WHERE  au.UserId = u.UserId);
            INSERT dbo.aspnet_Users (ApplicationId, UserId, UserName, LoweredUserName, IsAnonymous, LastActivityDate)
            SELECT @AppId,
                   NEWID(),
                   Name,
                   LOWER(Name),
                   0,
                   @CurrentTimeUtc
            FROM   @tbNames;
            INSERT INTO @tbUsers
            SELECT UserId
            FROM   dbo.aspnet_Users AS au, @tbNames AS t
            WHERE  LOWER(t.Name) = au.LoweredUserName
                   AND au.ApplicationId = @AppId;
        END
    IF (EXISTS (SELECT *
                FROM   dbo.aspnet_UsersInRoles AS ur, @tbUsers AS tu, @tbRoles AS tr
                WHERE  tu.UserId = ur.UserId
                       AND tr.RoleId = ur.RoleId))
        BEGIN
            SELECT TOP 1 UserName,
                         RoleName
            FROM   dbo.aspnet_UsersInRoles AS ur, @tbUsers AS tu, @tbRoles AS tr, aspnet_Users AS u, aspnet_Roles AS r
            WHERE  u.UserId = tu.UserId
                   AND r.RoleId = tr.RoleId
                   AND tu.UserId = ur.UserId
                   AND tr.RoleId = ur.RoleId;
            IF (@TranStarted = 1)
                ROLLBACK;
            RETURN (3);
        END
    INSERT INTO dbo.aspnet_UsersInRoles (UserId, RoleId)
    SELECT UserId,
           RoleId
    FROM   @tbUsers, @tbRoles;
    IF (@TranStarted = 1)
        COMMIT TRANSACTION;
    RETURN (0);
END