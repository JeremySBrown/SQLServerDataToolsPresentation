CREATE FUNCTION [dbo].[ProfilePictureUrl]
(@ProfilePicture NVARCHAR (150))
RETURNS NVARCHAR (255)
AS
BEGIN
    DECLARE @Result AS NVARCHAR (255);
    SET @Result = ISNULL(@ProfilePicture, 'https://wwww.vstrator.com/content/images/defaultprofilepic.png');
    SET @Result = CASE WHEN CHARINDEX('/content', @Result) = 1 THEN 'https://www.vstrator.com' + @Result ELSE @Result END;
    RETURN Lower(@Result);
END