CREATE VIEW [dbo].[CoachAssignmentStatusView]
AS
SELECT i.Id AS [InvitationId],
       i.InvitationAccepted,
       i.InvitationAcceptedDate,
       i.InvitationDeleted,
       ca.ID AS [CoachAssignmentId],
       ca.AthleteUserID,
       up1.UserName AS [AthleteUserName],
       ca.CoachUserID,
       up2.UserName AS [CoachUserName],
       ca.ShareLevel,
       ca.CanDownload,
       ca.CanShare
FROM   Invitations AS i
       INNER JOIN
       CoachAssignments AS ca
       ON (i.InvitedToOrganizationID = ca.OrganizationID
           AND i.InvitedUserID = ca.AthleteUserID)
       INNER JOIN
       UserNameLookupView AS up1
       ON ca.AthleteUserID = up1.id
       INNER JOIN
       UserNameLookupView AS up2
       ON ca.CoachUserID = up2.id;