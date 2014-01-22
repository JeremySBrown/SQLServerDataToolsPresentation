CREATE TABLE [dbo].[CoachRequestContentCommunications] (
    [ID]                     INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [CoachRequestContentsID] UNIQUEIDENTIFIER NOT NULL,
    [CommunicationsID]       UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_CoachRequestContentCommunications_ToCoachRequests] FOREIGN KEY ([CoachRequestContentsID]) REFERENCES [dbo].[CoachRequestContents] ([ID]),
    CONSTRAINT [FK_CoachRequestContentCommunications_ToCommunications] FOREIGN KEY ([CommunicationsID]) REFERENCES [dbo].[Communications] ([ID])
);