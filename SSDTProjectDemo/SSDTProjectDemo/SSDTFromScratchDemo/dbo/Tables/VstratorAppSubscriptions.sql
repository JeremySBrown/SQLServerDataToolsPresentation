CREATE TABLE [dbo].[VstratorAppSubscriptions] (
    [UserID]        UNIQUEIDENTIFIER NOT NULL,
    [VstratorAppID] UNIQUEIDENTIFIER NOT NULL,
    [Active]        BIT              DEFAULT 1 NOT NULL,
    [DateCreated]   DATETIME         DEFAULT getdate() NOT NULL,
    CONSTRAINT [PK_VstratorAppSubscriptions] PRIMARY KEY CLUSTERED ([UserID] ASC, [VstratorAppID] ASC),
    CONSTRAINT [FK_VstratorAppSubscriptions_UserProfiles] FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_VstratorAppSubscriptions_VstratorApps] FOREIGN KEY ([VstratorAppID]) REFERENCES [dbo].[VstratorApps] ([ID])
);