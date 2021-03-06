﻿CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetUsersInRoles]
@ApplicationName NVARCHAR (256), @RoleName NVARCHAR (256)
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (1);
    DECLARE @RoleId AS UNIQUEIDENTIFIER;
    SELECT @RoleId = NULL;
    SELECT @RoleId = RoleId
    FROM   dbo.aspnet_Roles
    WHERE  LOWER(@RoleName) = LoweredRoleName
           AND ApplicationId = @ApplicationId;
    IF (@RoleId IS NULL)
        RETURN (1);
    SELECT   u.UserName
    FROM     dbo.aspnet_Users AS u, dbo.aspnet_UsersInRoles AS ur
    WHERE    u.UserId = ur.UserId
             AND @RoleId = ur.RoleId
             AND u.ApplicationId = @ApplicationId
    ORDER BY u.UserName;
    RETURN (0);
END