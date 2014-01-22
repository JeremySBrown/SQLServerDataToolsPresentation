CREATE TABLE [dbo].[NotificationButtons] (
    [ID]             UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [NotificationID] UNIQUEIDENTIFIER NOT NULL,
    [ButtonText]     NVARCHAR (100)   NOT NULL,
    [ButtonType]     INT              NOT NULL,
    [MediaType]      INT              NULL,
    [MediaID]        UNIQUEIDENTIFIER NULL,
    [ClickURI]       NVARCHAR (255)   NULL,
    [ResponseValue]  NVARCHAR (255)   NULL,
    [DisplayOrder]   INT              NOT NULL,
    [ButtonClicked]  BIT              DEFAULT 0 NOT NULL,
    CONSTRAINT [PK_NotificationButtons] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_NotificationButtons_Notifications] FOREIGN KEY ([NotificationID]) REFERENCES [dbo].[Notifications] ([ID]) ON DELETE CASCADE
);