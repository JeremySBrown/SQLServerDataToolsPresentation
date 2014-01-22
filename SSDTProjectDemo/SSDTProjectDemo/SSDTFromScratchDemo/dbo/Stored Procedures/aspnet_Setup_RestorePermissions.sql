CREATE PROCEDURE [dbo].[aspnet_Setup_RestorePermissions]
@name [sysname]
AS
BEGIN
    DECLARE @object AS sysname;
    DECLARE @protectType AS CHAR (10);
    DECLARE @action AS VARCHAR (60);
    DECLARE @grantee AS sysname;
    DECLARE @cmd AS NVARCHAR (500);
    DECLARE c1 CURSOR FORWARD_ONLY
        FOR SELECT Object,
                   ProtectType,
                   [Action],
                   Grantee
            FROM   #aspnet_Permissions
            WHERE  Object = @name;
    OPEN c1;
    FETCH c1 INTO @object, @protectType, @action, @grantee;
    WHILE (@@fetch_status = 0)
        BEGIN
            SET @cmd = @protectType + ' ' + @action + ' on ' + @object + ' TO [' + @grantee + ']';
            EXECUTE (@cmd);
            FETCH c1 INTO @object, @protectType, @action, @grantee;
        END
    CLOSE c1;
    DEALLOCATE c1;
END