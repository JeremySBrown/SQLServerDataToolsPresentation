CREATE TABLE [dbo].[Roles] (
    [RoleID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]   NVARCHAR (255) NULL,
    [Active] BIT            CONSTRAINT [DF_Roles_Active] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleID] ASC)
);