CREATE TABLE [dbo].[CoachRequestCommunications] (
    [ID]               INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [CoachRequestID]   UNIQUEIDENTIFIER NOT NULL,
    [CommunicationsID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_CoachRequestCommunications_ToCoachRequests] FOREIGN KEY ([CoachRequestID]) REFERENCES [dbo].[CoachRequests] ([ID]),
    CONSTRAINT [FK_CoachRequestCommunications_ToCommunications] FOREIGN KEY ([CommunicationsID]) REFERENCES [dbo].[Communications] ([ID])
);