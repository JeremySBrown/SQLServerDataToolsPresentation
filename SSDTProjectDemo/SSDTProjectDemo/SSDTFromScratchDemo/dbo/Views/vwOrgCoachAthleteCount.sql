CREATE VIEW [dbo].[vwOrgCoachAthleteCount]
AS
SELECT   ca.OrganizationID,
         ca.CoachUserID,
         Count(ca.AthleteUserID) AS Athletes
FROM     CoachAssignments AS ca
GROUP BY ca.OrganizationID, ca.CoachUserID;