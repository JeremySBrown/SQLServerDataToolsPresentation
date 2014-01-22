CREATE TABLE [dbo].[AppNotificationButtons] (
    [ID]                UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [AppNotificationID] UNIQUEIDENTIFIER NOT NULL,
    [ButtonText]        NVARCHAR (100)   NOT NULL,
    [ButtonType]        INT              NOT NULL,
    [MediaType]         INT              NULL,
    [MediaID]           UNIQUEIDENTIFIER NULL,
    [ClickURI]          NVARCHAR (255)   NULL,
    [ResponseValue]     NVARCHAR (255)   NULL,
    [DisplayOrder]      INT              NOT NULL,
    [ButtonClicked]     BIT              DEFAULT 0 NOT NULL,
    CONSTRAINT [PK_AppNotificationButtons] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_AppNotificationButtons_AppNotifications] FOREIGN KEY ([AppNotificationID]) REFERENCES [dbo].[AppNotifications] ([ID]) ON DELETE CASCADE
);