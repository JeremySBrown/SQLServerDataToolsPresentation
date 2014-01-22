CREATE TABLE [dbo].[VstratorApps] (
    [ID]          UNIQUEIDENTIFIER DEFAULT newid() NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [AppName]     NVARCHAR (255)   NOT NULL,
    [Active]      BIT              DEFAULT 1 NOT NULL,
    [DateCreated] DATETIME         DEFAULT getdate() NOT NULL
);