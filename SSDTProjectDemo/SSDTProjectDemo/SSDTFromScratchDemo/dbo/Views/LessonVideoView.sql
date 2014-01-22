CREATE VIEW [dbo].[LessonVideoView]
AS
SELECT cr.ID AS [LessonId],
       crc.[SessionVideoID],
       cr.[Price] AS [Fee],
       CASE WHEN cr.[CreditCardChargeId] IS NULL
                 AND cr.[Price] > 0 THEN 1 ELSE 0 END AS [PaymentRequired]
FROM   [dbo].[CoachRequestContents] AS crc
       INNER JOIN
       [dbo].[CoachRequests] AS cr
       ON crc.CoachRequestID = cr.id
WHERE  crc.SessionVideoID IS NOT NULL;