CREATE PROCEDURE [dbo].[ActivityLogInsertByUserName]
@UserName NVARCHAR (255), @ActivityType INT, @TargetId NVARCHAR (36)
AS
IF (@UserName IS NULL
    OR @UserName = '')
    INSERT  INTO ActivityLog ([ActivityType], [TargetId])
    VALUES                  (@ActivityType, @TargetID);
ELSE
    INSERT INTO ActivityLog ([ActivityType], [UserId], [TargetId])
    SELECT @ActivityType,
           up.Id,
           @TargetId
    FROM   UserProfiles AS up
           INNER JOIN
           aspnet_users AS au
           ON au.UserId = up.MembershipUserId
    WHERE  au.UserName = @UserName;
RETURN 0;