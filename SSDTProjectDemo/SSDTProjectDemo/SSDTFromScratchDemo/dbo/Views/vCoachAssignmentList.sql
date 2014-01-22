CREATE VIEW [dbo].[vCoachAssignmentList]
AS
SELECT   TOP (100) PERCENT CoachProfile.ID AS CoachID,
                           dbo.UserProfiles.ID AS AthleteID,
                           dbo.UserProfiles.FirstName,
                           dbo.UserProfiles.LastName,
                           dbo.CoachAssignments.OrganizationID
FROM     dbo.CoachAssignments
         INNER JOIN
         dbo.UserProfiles AS CoachProfile
         ON dbo.CoachAssignments.CoachUserID = CoachProfile.ID
         INNER JOIN
         dbo.UserProfiles
         ON dbo.CoachAssignments.AthleteUserID = dbo.UserProfiles.ID
ORDER BY CoachID, AthleteID;