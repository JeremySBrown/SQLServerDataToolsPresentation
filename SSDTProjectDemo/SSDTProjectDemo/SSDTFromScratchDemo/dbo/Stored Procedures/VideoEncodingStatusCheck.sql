CREATE PROCEDURE [dbo].[VideoEncodingStatusCheck]
@VideoKeys NVARCHAR (MAX)
AS
SELECT v.VideoId,
       v.VideoKey,
       v.EncodingStatus,
       v.VideoThumbnailUrl,
       v.VideoUrl
FROM   VideoSearchView AS v
       INNER JOIN
       dbo.GuidListToTable(@VideoKeys, ',') AS vkf
       ON v.VideoKey = vkf.value;
RETURN 0;