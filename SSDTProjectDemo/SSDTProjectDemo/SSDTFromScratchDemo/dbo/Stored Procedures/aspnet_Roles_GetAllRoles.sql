﻿CREATE PROCEDURE [dbo].[aspnet_Roles_GetAllRoles]
@ApplicationName NVARCHAR (256)
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN;
    SELECT   RoleName
    FROM     dbo.aspnet_Roles
    WHERE    ApplicationId = @ApplicationId
    ORDER BY RoleName;
END