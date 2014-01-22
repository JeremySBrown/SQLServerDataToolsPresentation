CREATE PROCEDURE [dbo].[ReportVstratorTotals]
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
       AND up.DebugUser <> 1;
INSERT INTO #ReportTable
SELECT 'Organizations',
       count(*)
FROM   Organizations;
INSERT INTO #ReportTable
SELECT   app.AppName,
         Count(sub.UserID) AS Total
FROM     [dbo].[VstratorApps] AS app
         INNER JOIN
         VstratorAppSubscriptions AS sub
         ON app.ID = sub.VstratorAppID
WHERE    app.ID <> 'E2FEA349-FA43-419D-8F13-9FBFDABA30D3'
GROUP BY (app.AppName);
SELECT *
FROM   #ReportTable;
DROP TABLE #ReportTable;
RETURN 0;