CREATE TABLE [dbo].[NotificationContents] (
    [Id]              UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [ContentTypeId]   INT              NOT NULL,
    [Body]            NVARCHAR (MAX)   NOT NULL,
    [TextBody]        NVARCHAR (MAX)   NOT NULL,
    [Subject]         NVARCHAR (100)   NOT NULL,
    [FromAddress]     NVARCHAR (255)   NOT NULL,
    [FromDisplayName] NVARCHAR (50)    NOT NULL,
    [IsActive]        BIT              NOT NULL,
    [Version]         NUMERIC (4, 1)   DEFAULT 1.0 NOT NULL,
    [DateCreated]     DATETIME2 (7)    DEFAULT GetDate() NOT NULL,
    [DateModified]    DATETIME2 (7)    DEFAULT GetDate() NOT NULL
);