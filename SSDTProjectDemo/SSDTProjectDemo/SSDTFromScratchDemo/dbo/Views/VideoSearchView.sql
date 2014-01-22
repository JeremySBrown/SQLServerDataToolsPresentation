CREATE VIEW [dbo].[VideoSearchView]
AS
SELECT v.ClipVideoId AS [VideoId],
       0 AS [VideoType],
       v.ClipTypeId AS [VideoSubtype],
       v.ClipVideoKey AS [VideoKey],
       NULL AS [ParentKey],
       v.StorageLocation,
       v.StorageContainer,
       v.StorageKey,
       NULL AS [RecordingKey],
       dbo.VideoUrl(0, v.StorageContainer, v.StorageKey) AS [VideoUrl],
       dbo.VideoThumbnailUrl(0, v.StorageContainer, v.StorageKey) AS [VideoThumbnailUrl],
       v.Title,
       IsNull(ActivityDate, getdate()) AS [VideoDate],
       v.ClipDate AS [UploadedDate],
       v.EncodingStatus,
       v.Latitude,
       v.Longitude,
       v.Sport,
       v.[Action],
       v.Notes,
       v.IsPublic,
       v.IsPrivate,
       v.ClippedByUserID AS [UploadedById],
       v.OrganizationId,
       o.OrganizationName,
       v.OwnerId,
       a.FirstName AS [OwnerFirstName],
       a.LastName AS [OwnerLastName],
       dbo.ProfilePictureUrl(a.ProfilePicture) AS [OwnerProfilePhoto],
       v.CoachInstructorID AS [InstructorId],
       i.FirstName AS [InstructorFirstName],
       i.LastName AS [InstructorLastName],
       dbo.ProfilePictureUrl(i.ProfilePicture) AS [InstructorProfilePhoto],
       NULL AS [LessonId],
       0 AS [Fee],
       CAST (0 AS BIT) AS [PaymentRequired]
FROM   ClipVideos AS v
       LEFT OUTER JOIN
       UserProfiles AS a
       ON v.OwnerId = a.ID
       LEFT OUTER JOIN
       UserProfiles AS i
       ON v.CoachInstructorID = i.ID
       LEFT OUTER JOIN
       Organizations AS o
       ON v.OrganizationID = o.ID
WHERE  v.Deleted = 0
       AND v.StorageKey IS NOT NULL
UNION ALL
SELECT v.SessionVideoID AS [VideoId],
       1 AS [VideoType],
       v.SessionTypeID AS [VideoSubtype],
       v.SessionVideoKey AS [VideoKey],
       v.FramesKey AS [ParentKey],
       v.StorageLocation,
       v.StorageContainer,
       v.StorageKey,
       v.RecordingKey,
       dbo.VideoUrl(1, v.StorageContainer, v.StorageKey) AS [VideoUrl],
       dbo.VideoThumbnailUrl(1, v.StorageContainer, v.StorageKey) AS [VideoThumbnailUrl],
       v.Title,
       v.TelestrationDate AS [VideoDate],
       v.TelestrationDate AS [UploadedDate],
       v.EncodingStatus,
       v.Latitude,
       v.Longitude,
       v.Sport,
       v.[Action],
       v.Notes,
       v.IsPublic,
       v.IsPrivate,
       v.TelestratedByUserId AS [UploadedById],
       v.OrganizationId,
       o.OrganizationName,
       v.OwnerId,
       a.FirstName AS [OwnerFirstName],
       a.LastName AS [OwnerLastName],
       dbo.ProfilePictureUrl(a.ProfilePicture) AS [OwnerProfilePhoto],
       v.TelestratedByUserId AS [InstructorId],
       i.FirstName AS [InstructorFirstName],
       i.LastName AS [InstructorLastName],
       dbo.ProfilePictureUrl(i.ProfilePicture) AS [InstructorProfilePhoto],
       l.LessonId,
       l.Fee,
       CAST (l.PaymentRequired AS BIT) AS [PaymentRequired]
FROM   SessionVideos AS v
       LEFT OUTER JOIN
       LessonVideoView AS l
       ON v.SessionVideoID = l.SessionVideoID
       LEFT OUTER JOIN
       UserProfiles AS a
       ON v.OwnerId = a.ID
       LEFT OUTER JOIN
       UserProfiles AS i
       ON v.TelestratedByUserId = i.ID
       LEFT OUTER JOIN
       Organizations AS o
       ON v.OrganizationID = o.ID
WHERE  v.Deleted = 0
       AND v.StorageKey IS NOT NULL
       AND v.SessionTypeID <> 4;