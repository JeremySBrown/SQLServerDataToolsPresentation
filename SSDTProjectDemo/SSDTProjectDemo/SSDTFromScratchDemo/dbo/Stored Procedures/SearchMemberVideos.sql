CREATE PROCEDURE [dbo].[SearchMemberVideos]
@MemberId UNIQUEIDENTIFIER, @InstructorId UNIQUEIDENTIFIER, @QuickSearch NVARCHAR (255), @VideoType INT
AS
DECLARE @SearchTerm AS NVARCHAR (257);
DECLARE @CanSearchMemberVideos AS BIT;
SET @SearchTerm = '%' + @QuickSearch + '%';
SET @CanSearchMemberVideos = dbo.IsCoachForMember(@MemberId, @InstructorId);
SELECT *
FROM   [dbo].[VideoSearchView]
WHERE  @CanSearchMemberVideos = 1
       AND (OwnerId = @MemberId)
       AND (InstructorId = @InstructorId
            OR IsPublic = 1
            OR IsPrivate IS NULL
            OR IsPrivate = 0)
       AND NOT VideoSubtype IN (88, 4)
       AND (@VideoType IS NULL
            OR VideoType = @VideoType)
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