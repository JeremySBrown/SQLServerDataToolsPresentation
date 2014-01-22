CREATE PROCEDURE [dbo].[CanCoachAccessAthleteVideos]
@AthleteUserID UNIQUEIDENTIFIER, @AthleteUserName NVARCHAR (50), @CoachUserID UNIQUEIDENTIFIER, @CoachUserName NVARCHAR (50)
AS
DECLARE @IsRequestFromOwner AS INT;
SELECT @IsRequestFromOwner = count(ID)
FROM   UserNameLookupView
WHERE  (UserName IN (@AthleteUserName, @CoachUserName))
       OR (Id IN (@AthleteUserID, @CoachUserID));
IF @IsRequestFromOwner = 1
    BEGIN
        SELECT 1;
        RETURN 0;
    END
IF (@AthleteUserID IS NULL
    AND @AthleteUserName IS NULL)
   OR (@CoachUserID IS NULL
       AND @CoachUserName IS NULL)
    BEGIN
        SELECT 0;
        RETURN 0;
    END
IF EXISTS (SELECT InvitationId
           FROM   CoachAssignmentStatusView
           WHERE  (AthleteUserID = @AthleteUserID
                   OR @AthleteUserID IS NULL)
                  AND (AthleteUserName = @AthleteUserName
                       OR @AthleteUserName IS NULL)
                  AND (CoachUserID = @CoachUserID
                       OR @CoachUserID IS NULL)
                  AND (CoachUserName = @CoachUserName
                       OR @CoachUserName IS NULL)
                  AND InvitationAccepted = 1)
    SELECT 1;
ELSE
    SELECT 0;
RETURN 0;