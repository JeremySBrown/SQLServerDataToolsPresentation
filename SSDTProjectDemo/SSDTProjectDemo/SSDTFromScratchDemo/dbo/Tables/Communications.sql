CREATE TABLE [dbo].[Communications] (
    [ID]                    UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [CommunicationTypeID]   INT              NOT NULL,
    [SenderID]              UNIQUEIDENTIFIER NOT NULL,
    [RecipientID]           UNIQUEIDENTIFIER NOT NULL,
    [CommunicationStatusID] INT              NOT NULL,
    [Subject]               NVARCHAR (150)   NOT NULL,
    [Message]               NVARCHAR (MAX)   NOT NULL,
    [DateCreated]           DATETIME2 (7)    NOT NULL,
    [DateSent]              DATETIME2 (7)    NOT NULL,
    CONSTRAINT [FK_Communications_ToUserProfile_Recipient] FOREIGN KEY ([RecipientID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_Communications_ToUserProfile_Sender] FOREIGN KEY ([SenderID]) REFERENCES [dbo].[UserProfiles] ([ID])
);
GO
CREATE NONCLUSTERED INDEX [IX_Communications_CommunicationStatusID]
    ON [dbo].[Communications]([CommunicationStatusID] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_Communications_CommunicationTypeID]
    ON [dbo].[Communications]([CommunicationTypeID] ASC);