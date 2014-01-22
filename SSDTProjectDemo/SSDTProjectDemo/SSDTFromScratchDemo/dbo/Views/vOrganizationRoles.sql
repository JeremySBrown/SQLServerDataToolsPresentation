CREATE VIEW [dbo].[vOrganizationRoles]
AS
SELECT dbo.UserProfiles.ID AS UserID,
       dbo.Organizations.OrganizationName,
       dbo.Organizations.ID AS OrganizationID,
       dbo.Roles.RoleID,
       dbo.Roles.Name
FROM   dbo.UserProfiles
       INNER JOIN
       dbo.RoleAssignments
       ON dbo.UserProfiles.ID = dbo.RoleAssignments.UserID
       INNER JOIN
       dbo.Roles
       ON dbo.RoleAssignments.RoleID = dbo.Roles.RoleID
       INNER JOIN
       dbo.Organizations
       ON dbo.RoleAssignments.OrganizationID = dbo.Organizations.ID;