CREATE PROCEDURE [dbo].[aspnet_Membership_FindUsersByEmail]
@ApplicationName NVARCHAR (256), @EmailToMatch NVARCHAR (256), @PageIndex INT, @PageSize INT
AS
BEGIN
    DECLARE @ApplicationId AS UNIQUEIDENTIFIER;
    SELECT @ApplicationId = NULL;
    SELECT @ApplicationId = ApplicationId
    FROM   dbo.aspnet_Applications
    WHERE  LOWER(@ApplicationName) = LoweredApplicationName;
    IF (@ApplicationId IS NULL)
        RETURN 0;
    DECLARE @PageLowerBound AS INT;
    DECLARE @PageUpperBound AS INT;
    DECLARE @TotalRecords AS INT;
    SET @PageLowerBound = @PageSize * @PageIndex;
    SET @PageUpperBound = @PageSize - 1 + @PageLowerBound;
    CREATE TABLE #PageIndexForUsers (
        IndexId INT              IDENTITY (0, 1) NOT NULL,
        UserId  UNIQUEIDENTIFIER
    );
    IF (@EmailToMatch IS NULL)
        INSERT INTO #PageIndexForUsers (UserId)
        SELECT   u.UserId
        FROM     dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
        WHERE    u.ApplicationId = @ApplicationId
                 AND m.UserId = u.UserId
                 AND m.Email IS NULL
        ORDER BY m.LoweredEmail;
    ELSE
        INSERT INTO #PageIndexForUsers (UserId)
        SELECT   u.UserId
        FROM     dbo.aspnet_Users AS u, dbo.aspnet_Membership AS m
        WHERE    u.ApplicationId = @ApplicationId
                 AND m.UserId = u.UserId
                 AND m.LoweredEmail LIKE LOWER(@EmailToMatch)
        ORDER BY m.LoweredEmail;
    SELECT   u.UserName,
             m.Email,
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
    FROM     dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u, #PageIndexForUsers AS p
    WHERE    u.UserId = p.UserId
             AND u.UserId = m.UserId
             AND p.IndexId >= @PageLowerBound
             AND p.IndexId <= @PageUpperBound
    ORDER BY m.LoweredEmail;
    SELECT @TotalRecords = COUNT(*)
    FROM   #PageIndexForUsers;
    RETURN @TotalRecords;
END