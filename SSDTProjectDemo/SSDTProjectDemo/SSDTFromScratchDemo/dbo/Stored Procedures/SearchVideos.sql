CREATE PROCEDURE [dbo].[SearchVideos]
@OwnerId UNIQUEIDENTIFIER, @AthleteFilter NVARCHAR (MAX), @InstructorFilter NVARCHAR (MAX), @OrganizationFilter NVARCHAR (MAX), @QuickSearch NVARCHAR (255), @VideoType INT, @VideoSubtype INT
AS
DECLARE @SearchTerm AS NVARCHAR (257);
SET @SearchTerm = '%' + @QuickSearch + '%';
SELECT v.*
FROM   VideoSearchView AS v
       LEFT OUTER JOIN
       dbo.GuidListToTable(@AthleteFilter, ',') AS af
       ON v.OwnerId = af.value
       LEFT OUTER JOIN
       dbo.GuidListToTable(@OrganizationFilter, ',') AS orgf
       ON v.OrganizationId = orgf.value
       LEFT OUTER JOIN
       dbo.GuidListToTable(@InstructorFilter, ',') AS cf
       ON v.InstructorId = cf.value
WHERE  (@OwnerID = OwnerID
        OR @OwnerID = InstructorId
        OR (VideoSubtype = 99
            AND @VideoSubtype = 99))
       AND (@AthleteFilter IS NULL
            OR NOT af.value IS NULL)
       AND (@OrganizationFilter IS NULL
            OR NOT orgf.value IS NULL)
       AND (@InstructorFilter IS NULL
            OR NOT cf.value IS NULL)
       AND (@VideoType IS NULL
            OR VideoType = @VideoType)
       AND (@VideoSubtype IS NULL
            OR VideoSubtype = @VideoSubtype)
       AND (@QuickSearch IS NULL
            OR Notes LIKE @SearchTerm
            OR Title LIKE @SearchTerm
            OR OwnerFirstName LIKE @SearchTerm
            OR OwnerLastName LIKE @SearchTerm
            OR OwnerFirstName + ' ' + OwnerLastName LIKE @SearchTerm
            OR InstructorFirstName LIKE @SearchTerm
            OR InstructorLastName LIKE @SearchTerm
            OR InstructorFirstName + ' ' + InstructorLastName LIKE @SearchTerm
            OR OrganizationName LIKE @SearchTerm
            OR Sport LIKE @SearchTerm
            OR [Action] LIKE @SearchTerm);
RETURN 0;