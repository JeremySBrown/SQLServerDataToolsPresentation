CREATE VIEW [dbo].[DashboardSummaryView]
AS
SELECT VideoKey AS [SummaryId],
       'Video' AS [SummaryType],
       v.UploadedDate AS [SummaryDate],
       a.ID AS [AthleteId],
       a.FirstName AS [AthleteFirstName],
       a.LastName AS [AthleteLastName],
       dbo.ProfilePictureUrl(a.ProfilePicture) AS [AthletePhotoUrl],
       c.ID AS [CoachId],
       dbo.ProfilePictureUrl(c.ProfilePicture) AS [CoachPhotoUrl],
       c.FirstName AS [CoachFirstName],
       c.LastName AS [CoachLastName],
       v.UploadedByID,
       v.VideoUrl,
       v.VideoThumbnailUrl,
       v.VideoType,
       v.VideoSubtype,
       v.VideoKey,
       v.Title AS [VideoTitle],
       NULL AS [ConnectionAccepted],
       NULL AS [ConnectionAcceptedDate],
       isnull(v.Fee, 0) AS [LessonFee],
       isnull(v.PaymentRequired, 0) AS [PaymentRequired],
       v.LessonId
FROM   [dbo].[VideoSearchView] AS v
       INNER JOIN
       UserProfiles AS a
       ON v.OwnerID = a.ID
       INNER JOIN
       UserProfiles AS c
       ON v.InstructorID = c.ID
WHERE  v.VideoSubtype IN (1, 4)
UNION ALL
SELECT cr.ID AS [SummaryId],
       'Lesson Request' AS [SummaryType],
       cr.DateRequested AS [SummaryDate],
       a.ID AS [AthleteId],
       a.FirstName AS [AthleteFirstName],
       a.LastName AS [AthleteLastName],
       dbo.ProfilePictureUrl(a.ProfilePicture) AS [AthletePhotoUrl],
       c.ID AS [CoachId],
       dbo.ProfilePictureUrl(c.ProfilePicture) AS [CoachPhotoUrl],
       c.FirstName AS [CoachFirstName],
       c.LastName AS [CoachLastName],
       cv.ClippedByUserID AS [UploadedByID],
       dbo.VideoUrl(0, cv.StorageContainer, cv.ClipVideoKey) AS [VideoUrl],
       dbo.VideoThumbnailUrl(0, cv.StorageContainer, cv.ClipVideoKey) AS [VideoThumbnailUrl],
       0 AS [VideoType],
       cv.ClipTypeID AS [VideoSubtype],
       cv.ClipVideoKey AS [VideoKey],
       cr.[Subject] AS [VideoTitle],
       NULL AS [ConnectionAccepted],
       NULL AS [ConnectionAcceptedDate],
       isnull(cr.Price, 0) AS [LessonFee],
       CAST (CASE WHEN cr.[CreditCardChargeId] IS NULL
                       AND cr.[Price] > 0 THEN 1 ELSE 0 END AS BIT) AS [PaymentRequired],
       cr.ID AS [LessonId]
FROM   CoachRequests AS cr
       INNER JOIN
       UserProfiles AS a
       ON cr.AthleteID = a.id
       INNER JOIN
       UserProfiles AS c
       ON cr.CoachID = c.id
       INNER JOIN
       CoachRequestContents AS crc
       ON cr.ID = crc.CoachRequestID
       INNER JOIN
       ClipVideos AS cv
       ON crc.ClipVideoID = cv.ClipVideoID
WHERE  cr.CoachRequestStatusID = 1
UNION ALL
SELECT i.ID AS [SummaryId],
       'Connection' AS [SummaryType],
       IsNull(InvitationAcceptedDate, [InvitationSentDate]) AS [SummaryDate],
       a.ID AS [AthleteId],
       a.FirstName AS [AthleteFirstName],
       a.LastName AS [AthleteLastName],
       dbo.ProfilePictureUrl(a.ProfilePicture) AS [AtheltePhotoUrl],
       c.ID AS [CoachId],
       dbo.ProfilePictureUrl(c.ProfilePicture) AS [CoachPhotoUrl],
       c.FirstName AS [CoachFirstName],
       c.LastName AS [CoachLastName],
       NULL AS [UploadedByID],
       NULL AS [VideoUrl],
       NULL AS [VideoThumbnailUrl],
       NULL AS [VideoType],
       NULL AS [VideoSubtype],
       NULL AS [VideoKey],
       NULL AS [VideoTitle],
       InvitationAccepted AS [ConnectionAccepted],
       InvitationAcceptedDate AS [ConnectionAcceptedDate],
       0 AS [LessonFee],
       0 AS [PaymentRequired],
       NULL AS [LessonId]
FROM   [dbo].[Invitations] AS i
       INNER JOIN
       UserProfiles AS a
       ON i.InvitedUserID = a.id
       INNER JOIN
       UserProfiles AS c
       ON i.InvitedByID = c.id
WHERE  [InvitationDeleted] = 0
       AND [InvitationType] = 5;