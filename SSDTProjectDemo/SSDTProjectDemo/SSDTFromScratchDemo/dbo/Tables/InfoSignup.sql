CREATE TABLE [dbo].[InfoSignup] (
    [InfoID]         INT            IDENTITY (1, 1) NOT NULL,
    [EmailAddress]   NVARCHAR (255) NULL,
    [SignupDate]     DATETIME       NULL,
    [InvitationSent] BIT            CONSTRAINT [ColumnDefault_237212e7-8bc0-4d3c-b510-4a1a52d056f6] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PrimaryKey_a6143d9a-8ff6-40fc-9569-ce74f51f17f8] PRIMARY KEY CLUSTERED ([InfoID] ASC)
);