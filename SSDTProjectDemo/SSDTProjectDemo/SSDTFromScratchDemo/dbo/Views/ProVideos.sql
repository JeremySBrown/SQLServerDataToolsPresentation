CREATE VIEW [dbo].[ProVideos]
AS
SELECT *
FROM   VideoSearchView
WHERE  VideoSubtype = 99;