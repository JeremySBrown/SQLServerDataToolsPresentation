CREATE VIEW [dbo].[vUserOrganizations]
AS
SELECT   TOP (100) PERCENT dbo.UserProfiles.ID AS UserID,
                           dbo.RoleAssignments.OrganizationID,
                           dbo.Organizations.OrganizationName,
                           COUNT(dbo.RoleAssignments.OrganizationID) AS RoleCount
FROM     dbo.UserProfiles
         INNER JOIN
         dbo.RoleAssignments
         ON dbo.UserProfiles.ID = dbo.RoleAssignments.UserID
         INNER JOIN
         dbo.Roles
         ON dbo.RoleAssignments.RoleID = dbo.Roles.RoleID
         INNER JOIN
         dbo.Organizations
         ON dbo.RoleAssignments.OrganizationID = dbo.Organizations.ID
GROUP BY dbo.UserProfiles.ID, dbo.RoleAssignments.OrganizationID, dbo.Organizations.OrganizationName
ORDER BY dbo.UserProfiles.ID;