CREATE FUNCTION [dbo].[IsCoach]
(@UserProfileID UNIQUEIDENTIFIER)
RETURNS BIT
AS
BEGIN
    DECLARE @Result AS BIT;
    SET @Result = 0;
    IF EXISTS (SELECT SubscriptionID
               FROM   Subscriptions
               WHERE  [UserID] = @UserProfileID
                      AND SubscriptionType IN (1, 10, 21, 22))
        SET @Result = 1;
    RETURN @Result;
END