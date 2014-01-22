CREATE TABLE [dbo].[AppNotifications] (
    [ID]               UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [VstratorAppID]    UNIQUEIDENTIFIER NOT NULL,
    [NotificationType] INT              NOT NULL,
    [MinimumInterval]  INT              DEFAULT 0 NOT NULL,
    [Title]            NVARCHAR (255)   NOT NULL,
    [Body]             NVARCHAR (MAX)   NULL,
    [ImageURI]         NVARCHAR (255)   NULL,
    [ContentType]      INT              NOT NULL CONSTRAINT [FK_AppNotifications_VstratorApps] FOREIGN KEY ([VstratorAppID]) REFERENCES [dbo].[VstratorApps] ([ID]),
    CONSTRAINT [PK_AppNotifications] PRIMARY KEY CLUSTERED ([ID] ASC)
);