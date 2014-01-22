CREATE FUNCTION [dbo].[GuidListToTable]
(@GuidList NVARCHAR (MAX), @Delimeter NVARCHAR (10))
RETURNS 
    @returntable TABLE (
        [value] UNIQUEIDENTIFIER NULL)
AS
BEGIN
    DECLARE @FoundIndex AS INT;
    SET @FoundIndex = CHARINDEX(@Delimeter, @GuidList);
    WHILE (@FoundIndex > 0)
        BEGIN
            INSERT INTO @returntable (Value)
            SELECT LTRIM(RTRIM(SUBSTRING(@GuidList, 1, @FoundIndex - 1))) AS Value;
            SET @GuidList = SUBSTRING(@GuidList, @FoundIndex + DATALENGTH(@Delimeter) / 2, LEN(@GuidList));
            SET @FoundIndex = CHARINDEX(@Delimeter, @GuidList);
        END
    INSERT INTO @returntable (Value)
    SELECT LTRIM(RTRIM(@GuidList)) AS Data;
    RETURN;
END