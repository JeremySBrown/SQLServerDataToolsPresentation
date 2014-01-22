CREATE TABLE [dbo].[RoleAssignments] (
    [RoleAssignmentID] INT              IDENTITY (1, 1) NOT NULL,
    [RoleID]           INT              NULL,
    [DefaultSite]      BIT              CONSTRAINT [DF_RoleAssignment_DefaultSite] DEFAULT ((0)) NOT NULL,
    [ShowInDirectory]  BIT              CONSTRAINT [ColumnDefault_4a45a34e-9a5a-45ec-b7c4-a4effa08a22b] DEFAULT ((1)) NOT NULL,
    [IsActive]         BIT              DEFAULT ((1)) NOT NULL,
    [UserID]           UNIQUEIDENTIFIER NULL,
    [OrganizationID]   UNIQUEIDENTIFIER NULL,
    [DateCreated]      DATETIME         DEFAULT getdate() NOT NULL,
    CONSTRAINT [PK_RoleAssignment] PRIMARY KEY CLUSTERED ([RoleAssignmentID] ASC),
    CONSTRAINT [FK_RoleAssignment_Organizations] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organizations] ([ID]),
    CONSTRAINT [FK_RoleAssignment_Roles] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT [FK_RoleAssignment_UserProfiles] FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserProfiles] ([ID])
);