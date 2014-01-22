CREATE TABLE [dbo].[RegistrationLinks] (
    [Id]             INT              IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [LinkKey]        NVARCHAR (50)    NOT NULL,
    [OrganizationId] UNIQUEIDENTIFIER NOT NULL,
    [CoachId]        UNIQUEIDENTIFIER NOT NULL,
    [DateCreated]    DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    [IsActive]       BIT              DEFAULT 1 NOT NULL,
    CONSTRAINT [FK_RegistrationLinks_CoachUserProfile] FOREIGN KEY ([CoachId]) REFERENCES [dbo].[UserProfiles] ([ID]),
    CONSTRAINT [FK_RegistrationLinks_Organizations] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organizations] ([ID])
);
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_RegistrationLinks_LinkKey]
    ON [dbo].[RegistrationLinks]([LinkKey] ASC);