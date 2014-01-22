CREATE TABLE [dbo].[ActivityLog] (
    [Id]           INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [ActivityType] INT              NOT NULL,
    [UserId]       UNIQUEIDENTIFIER NULL,
    [TargetId]     NVARCHAR (36)    NOT NULL,
    [DateCreated]  DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    CONSTRAINT [FK_ActivityLog_UserProfiles] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserProfiles] ([ID])
);