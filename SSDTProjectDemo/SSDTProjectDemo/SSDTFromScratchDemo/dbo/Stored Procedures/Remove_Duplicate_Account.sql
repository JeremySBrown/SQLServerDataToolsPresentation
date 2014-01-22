CREATE PROCEDURE [dbo].[Remove_Duplicate_Account]
@EmailAddress NVARCHAR (250)
AS
DECLARE @GoodId AS UNIQUEIDENTIFIER;
DECLARE @SocialMediaId AS NVARCHAR (255);
SELECT @GoodId = Id
FROM   UserProfiles AS up
       INNER JOIN
       aspnet_membership AS m
       ON up.MembershipUserID = m.UserId
WHERE  m.Email = @EmailAddress;
SELECT TOP 1 @SocialMediaId = up.SocialMediaID
FROM   UserProfiles AS up
WHERE  up.EmailAddress = @EmailAddress
       AND NOT up.SocialMediaID IS NULL;
SET XACT_ABORT ON;
BEGIN TRANSACTION;
UPDATE UserProfiles
SET    SocialMediaID = @SocialMediaId
WHERE  Id = @GoodId
       AND NOT @SocialMediaId IS NULL;
DELETE [dbo].[CoachRequestContentCommunications]
FROM   [dbo].[CoachRequestContentCommunications] AS ccc
       INNER JOIN
       [dbo].[CoachRequestContents] AS crc
       ON ccc.CoachRequestContentsID = crc.ID
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestId = cr.ID
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.AthleteID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequestCommunications]
FROM   [dbo].[CoachRequestCommunications] AS crc
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestId = cr.ID
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.AthleteID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequestContents]
FROM   [dbo].[CoachRequestContents] AS crc
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestId = cr.ID
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.AthleteID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequests]
FROM   [dbo].[CoachRequests] AS cr
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.AthleteID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequestContentCommunications]
FROM   [dbo].[CoachRequestContentCommunications] AS ccc
       INNER JOIN
       [dbo].[CoachRequestContents] AS crc
       ON ccc.CoachRequestContentsID = crc.ID
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestId = cr.ID
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.CoachID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequestCommunications]
FROM   [dbo].[CoachRequestCommunications] AS crc
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestId = cr.ID
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.CoachID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequestContents]
FROM   [dbo].[CoachRequestContents] AS crc
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestId = cr.ID
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.CoachID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[CoachRequests]
FROM   [dbo].[CoachRequests] AS cr
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cr.CoachID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE CoachFees
FROM   CoachFees AS cf
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON cf.UserProfileID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[Communications]
FROM   [dbo].[Communications] AS c
       LEFT OUTER JOIN
       [dbo].[UserProfiles] AS up1
       ON c.SenderID = up1.ID
       LEFT OUTER JOIN
       [dbo].[UserProfiles] AS up2
       ON c.RecipientID = up2.ID
WHERE  (up1.EmailAddress = @EmailAddress
        AND (up1.ID <> @GoodId
             OR @GoodId IS NULL))
       OR (up2.EmailAddress = @EmailAddress
           AND (up2.ID <> @GoodId
                OR @GoodId IS NULL));
DELETE ClipVideos
FROM   ClipVideos
       INNER JOIN
       UserProfiles
       ON ClipVideos.OwnerID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE RawVideos
FROM   RawVideos
       INNER JOIN
       UserProfiles
       ON RawVideos.OwnerID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE SessionVideos
FROM   SessionVideos
       INNER JOIN
       UserProfiles
       ON SessionVideos.OwnerID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE RoleAssignments
FROM   RoleAssignments
       INNER JOIN
       UserProfiles
       ON RoleAssignments.UserID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE CoachAssignments
FROM   CoachAssignments AS ca
       INNER JOIN
       UserProfiles AS up1
       ON ca.CoachUserID = up1.ID
       INNER JOIN
       UserProfiles AS up2
       ON ca.AthleteUserID = up2.ID
WHERE  (up1.EmailAddress = @EmailAddress
        AND (up1.ID <> @GoodId
             OR @GoodId IS NULL))
       OR (up2.EmailAddress = @EmailAddress
           AND (up2.ID <> @GoodId
                OR @GoodId IS NULL));
DELETE Invitations
FROM   Invitations
       INNER JOIN
       UserProfiles
       ON Invitations.InvitedUserID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE AuthTransactionLog
FROM   AuthTransactionLog
       INNER JOIN
       UserProfiles
       ON AuthTransactionLog.UserID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE Subscriptions
FROM   Subscriptions
       INNER JOIN
       UserProfiles
       ON Subscriptions.UserID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE AnonymousAppUsers
FROM   AnonymousAppUsers
       INNER JOIN
       UserProfiles
       ON AnonymousAppUsers.UserProfileID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE ActivityLog
FROM   ActivityLog
       INNER JOIN
       UserProfiles
       ON ActivityLog.UserID = UserProfiles.ID
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE [dbo].[VstratorAppSubscriptions]
FROM   [dbo].[VstratorAppSubscriptions] AS vas
       INNER JOIN
       [dbo].[UserProfiles] AS up
       ON vas.UserID = up.ID
WHERE  up.EmailAddress = @EmailAddress
       AND (up.ID <> @GoodId
            OR @GoodId IS NULL);
DELETE UserProfiles
WHERE  UserProfiles.EmailAddress = @EmailAddress
       AND (UserProfiles.ID <> @GoodId
            OR @GoodId IS NULL);
COMMIT TRANSACTION;
RETURN 0;