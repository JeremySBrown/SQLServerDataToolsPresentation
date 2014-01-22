CREATE TABLE [dbo].[AnonymousAppUsers] (
    [ID]            INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [AppUserID]     NVARCHAR (75)    NOT NULL,
    [VstratorAppID] UNIQUEIDENTIFIER NOT NULL,
    [UserProfileID] UNIQUEIDENTIFIER NULL,
    [DateCreated]   DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    CONSTRAINT [FK_AnonymousAppUser_VstratorApps] FOREIGN KEY ([VstratorAppID]) REFERENCES [dbo].[VstratorApps] ([ID]),
    CONSTRAINT [FK_AnonymousAppUsers_UserProfiles] FOREIGN KEY ([UserProfileID]) REFERENCES [dbo].[UserProfiles] ([ID])
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AnonymousAppUsers_AppUserID]
    ON [dbo].[AnonymousAppUsers]([AppUserID] ASC);