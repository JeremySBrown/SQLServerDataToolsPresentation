CREATE VIEW [dbo].[UserNameLookupView]
AS
SELECT up.Id,
       up.EmailAddress,
       m.Email AS [UserName],
       up.FirstName,
       up.LastName,
       up.MembershipUserID,
       m.LastLoginDate
FROM   UserProfiles AS up
       INNER JOIN
       aspnet_Membership AS m
       ON up.MembershipUserID = m.UserId;