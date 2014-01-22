CREATE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
@Application NVARCHAR (60), @PageIndex INT=0, @PageSize INT=15, @TotalCount INT OUTPUT
AS
SET NOCOUNT ON;
DECLARE @FirstTimeUTC AS DATETIME;
DECLARE @FirstSequence AS INT;
DECLARE @StartRow AS INT;
DECLARE @StartRowIndex AS INT;
SELECT @TotalCount = COUNT(1)
FROM   [ELMAH_Error]
WHERE  [Application] = @Application;
SET @StartRowIndex = @PageIndex * @PageSize + 1;
IF @StartRowIndex <= @TotalCount
    BEGIN
        SET ROWCOUNT @StartRowIndex;
        SELECT   @FirstTimeUTC = [TimeUtc],
                 @FirstSequence = [Sequence]
        FROM     [ELMAH_Error]
        WHERE    [Application] = @Application
        ORDER BY [TimeUtc] DESC, [Sequence] DESC;
    END
ELSE
    BEGIN
        SET @PageSize = 0;
    END
SET ROWCOUNT @PageSize;
SELECT   [ErrorId] AS errorId,
         [Application] AS application,
         [Host] AS host,
         [Type] AS type,
         [Source] AS source,
         [Message] AS message,
         [User] AS [user],
         [StatusCode] AS statusCode,
         CONVERT (VARCHAR (50), [TimeUtc], 126) + 'Z' AS time
FROM     [ELMAH_Error] AS error
WHERE    [Application] = @Application
         AND [TimeUtc] <= @FirstTimeUTC
         AND [Sequence] <= @FirstSequence
ORDER BY [TimeUtc] DESC, [Sequence] DESC
FOR      XML AUTO;