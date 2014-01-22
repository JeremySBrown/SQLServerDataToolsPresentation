CREATE PROCEDURE [dbo].[aspnet_Membership_GetAllUsers]
@ApplicationName NVARCHAR (256), @PageIndex INT, @PageSize INT
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
    INSERT INTO #PageIndexForUsers (UserId)
    SELECT   u.UserId
    FROM     dbo.aspnet_Membership AS m, dbo.aspnet_Users AS u
    WHERE    u.ApplicationId = @ApplicationId
             AND u.UserId = m.UserId
    ORDER BY u.UserName;
    SELECT @TotalRecords = @@ROWCOUNT;
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
    ORDER BY u.UserName;
    RETURN @TotalRecords;
END