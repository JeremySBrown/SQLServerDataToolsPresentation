CREATE VIEW [dbo].[vwOrgMemberProfileSummary]
AS
SELECT DISTINCT up.ID,
                ra.OrganizationID,
                up.FirstName,
                up.LastName,
                up.EmailAddress,
                up.ProfilePicture,
                CAST (up.ProfileText AS NVARCHAR (MAX)) AS ProfileText,
                ra.DateCreated AS DateJoined,
                up.City,
                up.StateProvince,
                up.TotalClips,
                up.TotalVstratedClips,
                up.NewClips,
                up.NewVstratedClips,
                up.TotalFollowers,
                up.TotalFollowing,
                CASE WHEN i.InvitationAccepted = 0
                          AND i.InvitationAcceptedDate IS NULL THEN 'Pending' WHEN i.InvitationAccepted = 0
                                                                                   AND NOT i.InvitationAcceptedDate IS NULL THEN 'Declined' WHEN i.InvitationAccepted = 1 THEN 'Accepted' ELSE '' END AS InvitationStatus,
                CASE ra.RoleID WHEN 2 THEN 'Administrator' WHEN 3 THEN 'Coach' WHEN 5 THEN 'Member' END AS MemberType
FROM   vwUserProfileSummary AS up
       INNER JOIN
       RoleAssignments AS ra
       ON up.ID = ra.UserID
       LEFT OUTER JOIN
       Invitations AS i
       ON up.ID = i.InvitedUserID
          AND ra.OrganizationID = i.InvitedToOrganizationID
WHERE  (ra.RoleID = i.InvitationType
        OR i.InvitationType IS NULL);