CREATE TABLE [dbo].[UserConnections] (
    [ID]               UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [ConnectionType]   INT              NOT NULL,
    [Permissions]      INT              NOT NULL,
    [ConnectionStatus] INT              DEFAULT ((0)) NOT NULL,
    [Active]           BIT              DEFAULT ((1)) NOT NULL,
    [DateCreated]      DATETIME         DEFAULT (getdate()) NOT NULL,
    [LastStatusCheck]  DATETIME         NULL,
    [FromUserID]       UNIQUEIDENTIFIER DEFAULT ('00000000-0000-0000-0000-000000000000') NOT NULL,
    [ToUserID]         UNIQUEIDENTIFIER DEFAULT ('00000000-0000-0000-0000-000000000000') NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_UserConnections_From_UserProfiles] FOREIGN KEY ([FromUserID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_UserConnections_To_UserProfiles] FOREIGN KEY ([ToUserID]) REFERENCES [dbo].[UserProfiles] ([ID])
);