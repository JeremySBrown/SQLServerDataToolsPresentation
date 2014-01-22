CREATE TABLE [dbo].[Invitations] (
    [InvitationID]            INT              DEFAULT 0 NOT NULL,
    [ID]                      UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [InvitationType]          INT              NULL,
    [InvitedRelationship]     INT              NULL,
    [InvitedEmail]            NVARCHAR (255)   NULL,
    [InvitedFirstName]        NVARCHAR (255)   NULL,
    [InvitedLastName]         NVARCHAR (255)   NULL,
    [InvitationAccepted]      BIT              CONSTRAINT [DF_Invitations_InvitationAccepted] DEFAULT ((0)) NOT NULL,
    [InvitationAcceptedDate]  DATETIME         NULL,
    [InvitationSentDate]      DATETIME         CONSTRAINT [DF_Invitations_InvitationSentDate] DEFAULT (getdate()) NOT NULL,
    [InvitationReminderSent]  BIT              CONSTRAINT [DF_Invitations_InvitationReminderSent] DEFAULT ((0)) NOT NULL,
    [InvitationDeleted]       BIT              CONSTRAINT [DF_Invitations_InvitationDeleted] DEFAULT ((0)) NOT NULL,
    [InvitedToOrganizationID] UNIQUEIDENTIFIER NULL,
    [InvitedByID]             UNIQUEIDENTIFIER NULL,
    [InvitedUserID]           UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_Invitations_1] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Invitations_UserProfiles] FOREIGN KEY ([InvitedUserID]) REFERENCES [dbo].[UserProfiles] ([ID])
);