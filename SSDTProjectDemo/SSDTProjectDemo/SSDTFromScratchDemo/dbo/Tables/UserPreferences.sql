CREATE TABLE [dbo].[UserPreferences] (
    [Id]              INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [UserProfileId]   UNIQUEIDENTIFIER NOT NULL,
    [PreferenceKey]   NVARCHAR (100)   NOT NULL,
    [PreferenceValue] NVARCHAR (1000)  NOT NULL,
    [ValueType]       INT              DEFAULT 0 NOT NULL,
    [Editable]        BIT              DEFAULT 0 NOT NULL,
    CONSTRAINT [FK_UserPreferences_UserProfiles] FOREIGN KEY ([UserProfileId]) REFERENCES [dbo].[UserProfiles] ([ID])
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserPreferences_UserProfilePreferenceKey]
    ON [dbo].[UserPreferences]([UserProfileId] ASC, [PreferenceKey] ASC);