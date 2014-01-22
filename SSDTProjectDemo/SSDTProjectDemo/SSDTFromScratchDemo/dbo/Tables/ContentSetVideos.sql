CREATE TABLE [dbo].[ContentSetVideos] (
    [ID]           UNIQUEIDENTIFIER NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [ContentSetID] UNIQUEIDENTIFIER NOT NULL,
    [VideoType]    INT              NOT NULL,
    [VideoID]      INT              NOT NULL,
    CONSTRAINT [FK_ContentSetVideos_ToContentSets] FOREIGN KEY ([ContentSetID]) REFERENCES [dbo].[ContentSets] ([ID])
);