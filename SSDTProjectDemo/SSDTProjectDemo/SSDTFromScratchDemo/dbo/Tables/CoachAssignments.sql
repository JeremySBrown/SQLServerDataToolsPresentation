CREATE TABLE [dbo].[CoachAssignments] (
    [ID]             UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [OrganizationID] UNIQUEIDENTIFIER NULL,
    [CoachUserID]    UNIQUEIDENTIFIER NOT NULL,
    [AthleteUserID]  UNIQUEIDENTIFIER NOT NULL,
    [ShareLevel]     INT              DEFAULT ((0)) NOT NULL,
    [DateCreated]    DATETIME         DEFAULT (getdate()) NOT NULL,
    [Status]         INT              DEFAULT ((0)) NOT NULL,
    [CanDownload]    BIT              DEFAULT ((0)) NOT NULL,
    [CanShare]       BIT              DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CoachAssignments_AthleteUserProfile] FOREIGN KEY ([AthleteUserID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_CoachAssignments_CoachUserProfile] FOREIGN KEY ([CoachUserID]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_CoachAssignments_Organizations] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organizations] ([ID])
);