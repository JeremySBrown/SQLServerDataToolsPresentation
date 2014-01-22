CREATE PROCEDURE [dbo].[UserLookupForCoachAssignments]
@UserName NVARCHAR (255)
AS
SELECT aup.Id,
       'Athlete' AS [LookupItemType],
       aup.FirstName + ' ' + aup.LastName AS [ItemText],
       CAST (aup.Id AS NVARCHAR (36)) AS [ItemValueString],
       NULL AS [ParentId],
       NULL AS [ItemValueType],
       CAST (ROW_NUMBER() OVER (ORDER BY aup.LastName, aup.FirstName) AS INT) AS [SortOrder]
FROM   CoachAssignments AS ca
       INNER JOIN
       UserNameLookupView AS cup
       ON ca.CoachUserID = cup.Id
       INNER JOIN
       UserNameLookupView AS aup
       ON ca.AthleteUserID = aup.Id
WHERE  cup.UserName = @UserName
UNION ALL
SELECT cup.Id,
       'Coach' AS [LookupItemType],
       cup.FirstName + ' ' + cup.LastName AS [ItemText],
       CAST (cup.Id AS NVARCHAR (36)) AS [ItemValueString],
       NULL AS [ParentId],
       NULL AS [ItemValueType],
       CAST (ROW_NUMBER() OVER (ORDER BY cup.LastName, cup.FirstName) AS INT) AS [SortOrder]
FROM   CoachAssignments AS ca
       INNER JOIN
       UserNameLookupView AS cup
       ON ca.CoachUserID = cup.Id
       INNER JOIN
       UserNameLookupView AS aup
       ON ca.AthleteUserID = aup.Id
WHERE  aup.UserName = @UserName;
RETURN 0;