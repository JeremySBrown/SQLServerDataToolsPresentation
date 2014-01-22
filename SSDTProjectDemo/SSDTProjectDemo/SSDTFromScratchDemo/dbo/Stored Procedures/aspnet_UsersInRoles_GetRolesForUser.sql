CREATE PROCEDURE [dbo].[aspnet_UsersInRoles_GetRolesForUser]
@ApplicationName NVARCHAR (256), @UserName NVARCHAR (256)
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN (1);
    DECLARE @UserId AS UNIQUEIDENTIFIER;
    SELECT @UserId = NULL;
    SELECT @UserId = UserId
    FROM   dbo.aspnet_Users
    WHERE  LoweredUserName = LOWER(@UserName)
           AND ApplicationId = @ApplicationId;
    IF (@UserId IS NULL)
        RETURN (1);
    SELECT   r.RoleName
    FROM     dbo.aspnet_Roles AS r, dbo.aspnet_UsersInRoles AS ur
    WHERE    r.RoleId = ur.RoleId
             AND r.ApplicationId = @ApplicationId
             AND ur.UserId = @UserId
    ORDER BY r.RoleName;
    RETURN (0);
END