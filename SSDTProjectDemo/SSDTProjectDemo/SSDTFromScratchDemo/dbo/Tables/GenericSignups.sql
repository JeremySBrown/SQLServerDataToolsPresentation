CREATE TABLE [dbo].[GenericSignups] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [SignupType]   NVARCHAR (100) NOT NULL,
    [SignupDate]   DATETIME       DEFAULT getdate() NOT NULL,
    [FirstName]    NVARCHAR (50)  NOT NULL,
    [LastName]     NVARCHAR (50)  NOT NULL,
    [EmailAddress] NVARCHAR (100) NOT NULL,
    [DateOfBirth]  DATETIME       NULL,
    [Street1]      NVARCHAR (50)  NULL,
    [Street2]      NVARCHAR (50)  NULL,
    [City]         NVARCHAR (50)  NULL,
    [State]        NVARCHAR (2)   NULL,
    [PostalCode]   NVARCHAR (20)  NULL
);