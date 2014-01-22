CREATE FUNCTION [dbo].[IsCoachForMember]
(@MemberId UNIQUEIDENTIFIER, @CoachId UNIQUEIDENTIFIER)
RETURNS BIT
AS
BEGIN
    DECLARE @Result AS BIT;
    SET @Result = 0;
    IF (dbo.IsCoach(@CoachId) = 1
        AND EXISTS (SELECT ID
                    FROM   CoachAssignments
                    WHERE  AthleteUserID = @MemberId
                           AND CoachUserID = @CoachId))
        SET @Result = 1;
    RETURN @Result;
END