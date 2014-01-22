CREATE TABLE [dbo].[OrganizationVideos] (
    [OrganizationID] UNIQUEIDENTIFIER NOT NULL,
    [VideoID]        INT              NOT NULL,
    CONSTRAINT [PK_OrganizationVideos] PRIMARY KEY CLUSTERED ([OrganizationID] ASC, [VideoID] ASC),
    CONSTRAINT [FK_OrganizationVideos_ToOrganizations] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organizations] ([ID]),
    CONSTRAINT [FK_OrganizationVideos_Videos] FOREIGN KEY ([VideoID]) REFERENCES [dbo].[Videos] ([VideoID])
);