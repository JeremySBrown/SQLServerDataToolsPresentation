CREATE TABLE [dbo].[UserTasks] (
    [Id]            INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [TaskId]        NVARCHAR (100)   NOT NULL,
    [UserProfileId] UNIQUEIDENTIFIER NOT NULL
);
GO
CREATE NONCLUSTERED INDEX [IX_UserTasks_UserTaskId]
    ON [dbo].[UserTasks]([UserProfileId] ASC, [TaskId] ASC);