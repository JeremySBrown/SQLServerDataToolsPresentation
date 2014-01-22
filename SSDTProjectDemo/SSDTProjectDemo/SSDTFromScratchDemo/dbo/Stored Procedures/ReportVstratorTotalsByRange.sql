CREATE PROCEDURE [dbo].[ReportVstratorTotalsByRange]
@StartDate DATETIME, @EndDate DATETIME
AS
CREATE TABLE #ReportTable (
    ReportItem NVARCHAR (255) NOT NULL,
    Total      INT            NOT NULL
);
INSERT INTO #ReportTable
SELECT 'Vstrator.com',
       count(*)
FROM   userprofiles AS up
WHERE  up.ID NOT IN (SELECT UserID
                     FROM   [dbo].[VstratorAppSubscriptions])
       AND up.DateCreated BETWEEN @StartDate AND @EndDate
       AND up.DebugUser <> 1;
INSERT INTO #ReportTable
SELECT 'Organizations',
       count(*)
FROM   Organizations
WHERE  DateCreated BETWEEN @StartDate AND @EndDate;
INSERT INTO #ReportTable
SELECT   app.AppName,
         Count(sub.UserID) AS Total
FROM     [dbo].[VstratorApps] AS app
         LEFT OUTER JOIN
         VstratorAppSubscriptions AS sub
         ON app.ID = sub.VstratorAppID
            AND sub.DateCreated BETWEEN @StartDate AND @EndDate
WHERE    app.ID <> 'E2FEA349-FA43-419D-8F13-9FBFDABA30D3'
GROUP BY (app.AppName);
INSERT INTO #ReportTable
SELECT 'Videos',
       count(*)
FROM   ClipVideos
WHERE  deleted != 1
       AND (cliptypeid <> 88
            OR cliptypeid IS NULL)
       AND clipdate BETWEEN @StartDate AND @EndDate;
INSERT INTO #ReportTable
SELECT 'Vstrated Videos',
       count(*)
FROM   SessionVideos
WHERE  deleted != 1
       AND (sessiontypeid <> 88
            OR sessiontypeid IS NULL)
       AND [TelestrationDate] BETWEEN @StartDate AND @EndDate;
SELECT *
FROM   #ReportTable;
DROP TABLE #ReportTable;
RETURN 0;