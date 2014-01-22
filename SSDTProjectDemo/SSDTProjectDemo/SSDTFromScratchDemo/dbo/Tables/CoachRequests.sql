CREATE TABLE [dbo].[CoachRequests] (
    [ID]                   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [CoachID]              UNIQUEIDENTIFIER NOT NULL,
    [AthleteID]            UNIQUEIDENTIFIER NOT NULL,
    [CoachRequestStatusID] INT              NOT NULL,
    [Subject]              NVARCHAR (150)   NULL,
    [Message]              NVARCHAR (MAX)   NULL,
    [Price]                MONEY            NOT NULL,
    [DateRequested]        DATETIME2 (7)    NOT NULL,
    [DateCompleted]        DATETIME2 (7)    NULL,
    [DateModified]         DATETIME2 (7)    NOT NULL,
    [CreditCardChargeId]   UNIQUEIDENTIFIER NULL,
    [Rating]               INT              DEFAULT 0 NOT NULL,
    [CoachComments]        NVARCHAR (MAX)   NULL,
    [AthleteComments]      NVARCHAR (MAX)   NULL,
    [RequestedByID]        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [FK_CoachRequests_CreditCardCharges] FOREIGN KEY ([CreditCardChargeId]) REFERENCES [dbo].[CreditCardCharges] ([Id]),
    CONSTRAINT [FK_CoachRequests_ToAthleteUserProfile] FOREIGN KEY ([AthleteID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_CoachRequests_ToCoachUserProfile] FOREIGN KEY ([CoachID]) REFERENCES [dbo].[UserProfiles] ([ID])
);
GO
CREATE NONCLUSTERED INDEX [IX_CoachRequests_CoachRequestStatusID]
    ON [dbo].[CoachRequests]([CoachRequestStatusID] ASC);