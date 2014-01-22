CREATE PROCEDURE [dbo].[aspnet_Setup_RemoveAllRoleMembers]
@name [sysname]
AS
BEGIN
    CREATE TABLE #aspnet_RoleMembers (
        Group_name     sysname ,
        Group_id       SMALLINT,
        Users_in_group sysname ,
        User_id        SMALLINT
    );
    INSERT INTO #aspnet_RoleMembers
    EXECUTE sp_helpuser @name;
    DECLARE @user_id AS SMALLINT;
    DECLARE @cmd AS NVARCHAR (500);
    DECLARE c1 CURSOR FORWARD_ONLY
        FOR SELECT User_id
            FROM   #aspnet_RoleMembers;
    OPEN c1;
    FETCH c1 INTO @user_id;
    WHILE (@@fetch_status = 0)
        BEGIN
            SET @cmd = 'EXEC sp_droprolemember ' + '''' + @name + ''', ''' + USER_NAME(@user_id) + '''';
            EXECUTE (@cmd);
            FETCH c1 INTO @user_id;
        END
    CLOSE c1;
    DEALLOCATE c1;
END