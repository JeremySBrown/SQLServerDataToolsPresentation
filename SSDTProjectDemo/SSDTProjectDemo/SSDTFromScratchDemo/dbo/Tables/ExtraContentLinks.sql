CREATE TABLE [dbo].[ExtraContentLinks] (
    [ID]          UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [ExtraID]     UNIQUEIDENTIFIER NOT NULL,
    [ContentType] INT              NOT NULL,
    [ContentUri]  NVARCHAR (255)   NOT NULL,
    CONSTRAINT [PK_ExtraContentLinks] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_ExtraContentLinks_Extras] FOREIGN KEY ([ExtraID]) REFERENCES [dbo].[Extras] ([ID]) ON DELETE CASCADE
);