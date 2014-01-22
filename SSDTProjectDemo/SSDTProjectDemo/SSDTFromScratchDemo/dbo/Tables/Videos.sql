CREATE TABLE [dbo].[Videos] (
    [VideoID]          INT              IDENTITY (1, 1) NOT NULL,
    [VideoKey]         UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [Title]            NVARCHAR (255)   NOT NULL,
    [Active]           BIT              DEFAULT 1 NOT NULL,
    [Description]      NVARCHAR (MAX)   NULL,
    [StorageLocation]  NVARCHAR (255)   NULL,
    [StorageContainer] NVARCHAR (255)   NULL,
    [StorageKey]       NVARCHAR (255)   NULL,
    [DateCreated]      DATETIME         DEFAULT getdate() NOT NULL,
    [DateModified]     DATETIME         DEFAULT getdate() NOT NULL,
    CONSTRAINT [PK_Videos] PRIMARY KEY CLUSTERED ([VideoID] ASC)
);