CREATE TABLE [dbo].[CoachFees] (
    [ID]             UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [UserProfileID]  UNIQUEIDENTIFIER NOT NULL,
    [OrganizationID] UNIQUEIDENTIFIER NULL,
    [PriceLevelID]   INT              NOT NULL,
    [Price]          MONEY            NOT NULL,
    [DateCreated]    DATETIME2 (7)    NOT NULL,
    [DateModified]   DATETIME2 (7)    NOT NULL,
    CONSTRAINT [FK_CoachFees_ToOrganization] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organizations] ([ID]),
    CONSTRAINT [FK_CoachFees_ToUserProfile] FOREIGN KEY ([UserProfileID]) REFERENCES [dbo].[UserProfiles] ([ID])
);
GO
CREATE NONCLUSTERED INDEX [IX_CoachFees_OrganizationID]
    ON [dbo].[CoachFees]([OrganizationID] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_CoachFees_UserProfileID]
    ON [dbo].[CoachFees]([UserProfileID] ASC);