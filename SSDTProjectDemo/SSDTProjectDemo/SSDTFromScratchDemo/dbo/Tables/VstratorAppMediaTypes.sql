CREATE TABLE [dbo].[VstratorAppMediaTypes] (
    [ID]            UNIQUEIDENTIFIER DEFAULT newid() NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [VstratorAppID] UNIQUEIDENTIFIER NOT NULL,
    [MediaType]     INT              NOT NULL,
    [MediaID]       UNIQUEIDENTIFIER NOT NULL,
    [Active]        BIT              DEFAULT 1 NOT NULL,
    [DateCreated]   DATETIME         DEFAULT getdate() NOT NULL,
    [DateModified]  DATETIME         DEFAULT getdate() NOT NULL,
    CONSTRAINT [FK_VstratorAppMediaTypes_VstratorApps] FOREIGN KEY ([VstratorAppID]) REFERENCES [dbo].[VstratorApps] ([ID]) ON DELETE CASCADE
);