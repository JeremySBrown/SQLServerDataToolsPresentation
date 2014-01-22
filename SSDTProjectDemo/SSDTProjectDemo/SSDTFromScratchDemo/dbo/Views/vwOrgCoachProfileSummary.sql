CREATE VIEW [dbo].[vwOrgCoachProfileSummary]
AS
SELECT up.ID,
       ra.OrganizationID,
       ra.RoleID,
       up.FirstName,
       up.LastName,
       up.EmailAddress,
       up.ProfilePicture,
       up.ProfileText,
       IsNull(ac.Athletes, 0) AS TotalAthletes,
       IsNull(mtd.MTD, 0) AS SessionsMTD,
       isNull(ytd.YTD, 0) AS SessionsYTD,
       CASE WHEN i.InvitationAccepted = 0
                 AND i.InvitationAcceptedDate IS NULL THEN 'Pending' WHEN i.InvitationAccepted = 0
                                                                          AND i.InvitationAcceptedDate IS NOT NULL THEN 'Declined' WHEN i.InvitationAccepted = 1 THEN 'Accepted' ELSE '' END AS InvitationStatus,
       ra.DateCreated AS DateJoined
FROM   RoleAssignments AS ra
       INNER JOIN
       UserProfiles AS up
       ON ra.UserID = up.ID
       LEFT OUTER JOIN
       vwOrgCoachSessionsMTD AS mtd
       ON ra.UserID = mtd.TelestratedByUserID
          AND ra.OrganizationID = mtd.OrganizationID
       LEFT OUTER JOIN
       vwOrgCoachSessionsYTD AS ytd
       ON ra.UserID = ytd.TelestratedByUserID
          AND ra.OrganizationID = ytd.OrganizationID
       LEFT OUTER JOIN
       Invitations AS i
       ON ra.UserID = i.InvitedUserID
          AND ra.OrganizationID = i.InvitedToOrganizationID
       LEFT OUTER JOIN
       vwOrgCoachAthleteCount AS ac
       ON ra.UserID = ac.CoachUserID
          AND ra.OrganizationID = ac.OrganizationID
WHERE  ra.RoleID = 3
       AND (i.ID IS NULL
            OR (i.InvitedRelationship = 3
                AND i.InvitationDeleted = 0));