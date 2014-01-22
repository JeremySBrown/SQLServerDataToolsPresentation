CREATE VIEW [dbo].[TopVstrators]
AS
SELECT   OwnerId AS [Id],
         OwnerFirstName AS [FirstName],
         OwnerLastName AS [LastName],
         OwnerProfilePhoto AS [ProfilePhoto],
         Count(*) AS TotalVideos
FROM     VideoSearchView
WHERE    OwnerID IS NOT NULL
         AND OwnerId NOT IN ('00000000-0000-0000-0000-000000000000', '6DC43553-1C36-4216-9905-40DD014C0F7B')
         AND VideoType = 1
GROUP BY OwnerId, OwnerFirstName, OwnerLastName, OwnerProfilePhoto
HAVING   count(*) > 100;