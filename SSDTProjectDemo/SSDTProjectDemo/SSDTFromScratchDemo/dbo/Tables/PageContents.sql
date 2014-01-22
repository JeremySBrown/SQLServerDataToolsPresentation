CREATE TABLE [dbo].[PageContents] (
    [Id]           UNIQUEIDENTIFIER DEFAULT newid() NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [Key]          NVARCHAR (100)   NOT NULL,
    [Content]      NVARCHAR (MAX)   NOT NULL,
    [DateCreated]  DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    [DateModified] DATETIME2 (7)    DEFAULT getdate() NOT NULL
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PageContents_Key]
    ON [dbo].[PageContents]([Key] ASC);