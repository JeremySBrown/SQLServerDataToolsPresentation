CREATE VIEW [dbo].[ClipVstratedCountView]
AS
SELECT   FramesKey AS ClipVideoKey,
         Count(FramesKey) AS VstratedCount
FROM     SessionVideos
GROUP BY FramesKey;