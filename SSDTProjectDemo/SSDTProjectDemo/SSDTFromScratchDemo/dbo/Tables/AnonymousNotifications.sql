CREATE TABLE [dbo].[AnonymousNotifications] (
    [AnonymousAppUserID] INT              NOT NULL,
    [AppNotificationID]  UNIQUEIDENTIFIER NOT NULL,
    [ResponseDate]       DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    PRIMARY KEY CLUSTERED ([AnonymousAppUserID] ASC, [AppNotificationID] ASC),
    CONSTRAINT [FK_AnonymousNotifications_AnonymousAppUsers] FOREIGN KEY ([AnonymousAppUserID]) REFERENCES [dbo].[AnonymousAppUsers] ([ID]),
    CONSTRAINT [FK_AnonymousNotifications_AppNotifications] FOREIGN KEY ([AppNotificationID]) REFERENCES [dbo].[AppNotifications] ([ID])
);