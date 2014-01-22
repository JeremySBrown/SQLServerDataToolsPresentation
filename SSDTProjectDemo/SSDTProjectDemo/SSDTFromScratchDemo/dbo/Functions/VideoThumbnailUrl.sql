CREATE FUNCTION [dbo].[VideoThumbnailUrl]
(@VideoType INT, @Container NVARCHAR (100), @VideoKey NVARCHAR (40))
RETURNS NVARCHAR (255)
AS
BEGIN
    DECLARE @Location AS NVARCHAR (50);
    DECLARE @Result AS NVARCHAR (255);
    SET @Location = 'https://vstrator.blob.core.windows.net/';
    SET @Result = CASE WHEN @VideoType = 0 THEN @Location + IsNull(@Container, 'clips') + '/' + @VideoKey + '/vclip00001.jpg' ELSE @Location + IsNull(@Container, 'output') + '/' + @VideoKey + 'thumb.jpg' END;
    RETURN Lower(@Result);
END