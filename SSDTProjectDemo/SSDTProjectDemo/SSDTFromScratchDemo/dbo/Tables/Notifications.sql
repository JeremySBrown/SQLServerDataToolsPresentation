CREATE TABLE [dbo].[Notifications] (
    [ID]               UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [VstratorAppID]    UNIQUEIDENTIFIER NOT NULL,
    [UserID]           UNIQUEIDENTIFIER NOT NULL,
    [NotificationType] INT              NOT NULL,
    [Title]            NVARCHAR (255)   NOT NULL,
    [Body]             NVARCHAR (MAX)   NULL,
    [ImageURI]         NVARCHAR (255)   NULL,
    [ContentType]      INT              NOT NULL,
    [NotificationDate] DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    [ResponseDate]     DATETIME2 (7)    NULL,
    CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Notifications_UserProfiles] FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_Notifications_VstratorApps] FOREIGN KEY ([VstratorAppID]) REFERENCES [dbo].[VstratorApps] ([ID])
);