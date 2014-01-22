CREATE FUNCTION [dbo].[IntegerListToTable]
(@GuidList NVARCHAR (MAX), @Delimeter NVARCHAR (10))
RETURNS 
    @returntable TABLE (
        [value] INT NULL)
AS
BEGIN
    DECLARE @FoundIndex AS INT;
    SET @FoundIndex = CHARINDEX(@Delimeter, @GuidList);
    WHILE (@FoundIndex > 0)
        BEGIN
            INSERT INTO @returntable (Value)
            SELECT CAST (LTRIM(RTRIM(SUBSTRING(@GuidList, 1, @FoundIndex - 1))) AS INT) AS Value;
            SET @GuidList = SUBSTRING(@GuidList, @FoundIndex + DATALENGTH(@Delimeter) / 2, LEN(@GuidList));
            SET @FoundIndex = CHARINDEX(@Delimeter, @GuidList);
        END
    INSERT INTO @returntable (Value)
    SELECT CAST (LTRIM(RTRIM(@GuidList)) AS INT) AS Data;
    RETURN;
END