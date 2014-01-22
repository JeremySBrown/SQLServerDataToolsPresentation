CREATE TABLE [dbo].[ContentSetPurchases] (
    [ContentSetID]   UNIQUEIDENTIFIER NOT NULL,
    [UserProfileID]  UNIQUEIDENTIFIER NOT NULL,
    [DateOfPurchase] DATETIME         NOT NULL,
    [TransactionID]  NVARCHAR (50)    NULL,
    PRIMARY KEY CLUSTERED ([ContentSetID] ASC, [UserProfileID] ASC),
    CONSTRAINT [FK_ContentSetPurchases_ContentSets] FOREIGN KEY ([ContentSetID]) REFERENCES [dbo].[ContentSets] ([ID]),
    CONSTRAINT [FK_ContentSetPurchases_UserProfiles] FOREIGN KEY ([UserProfileID]) REFERENCES [dbo].[UserProfiles] ([ID])
);