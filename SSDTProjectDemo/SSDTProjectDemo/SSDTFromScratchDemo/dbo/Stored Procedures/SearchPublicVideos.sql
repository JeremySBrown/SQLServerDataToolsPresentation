CREATE PROCEDURE [dbo].[SearchPublicVideos]
@OwnerId UNIQUEIDENTIFIER, @QuickSearch NVARCHAR (255), @VideoType INT, @VideoSubtype INT
AS
DECLARE @SearchTerm AS NVARCHAR (257);
SET @SearchTerm = '%' + @QuickSearch + '%';
SELECT v.*
FROM   VideoSearchView AS v
WHERE  (@OwnerId IS NULL
        OR OwnerId = @OwnerId)
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