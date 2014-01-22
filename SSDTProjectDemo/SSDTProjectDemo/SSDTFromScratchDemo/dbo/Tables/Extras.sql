CREATE TABLE [dbo].[Extras] (
    [ID]           UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [Title]        NVARCHAR (100)   NOT NULL,
    [Active]       BIT              DEFAULT 1 NOT NULL,
    [DateCreated]  DATETIME         DEFAULT getdate() NOT NULL,
    [DateModified] DATETIME         DEFAULT getdate() NOT NULL,
    CONSTRAINT [PK_Extras] PRIMARY KEY CLUSTERED ([ID] ASC)
);