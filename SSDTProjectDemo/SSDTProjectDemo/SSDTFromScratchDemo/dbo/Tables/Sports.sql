CREATE TABLE [dbo].[Sports] (
    [SportID]         INT            IDENTITY (1, 1) NOT NULL,
    [SportText]       NVARCHAR (50)  NULL,
    [BackgroundImage] NVARCHAR (255) NULL,
    [Active]          BIT            CONSTRAINT [ColumnDefault_499985ef-b381-4f5e-8a62-f6d573f9c502] DEFAULT ((0)) NOT NULL,
    [SortOrder]       INT            CONSTRAINT [ColumnDefault_1a3df500-bd7c-4d0b-b517-de009a4ed811] DEFAULT ((0)) NULL,
    CONSTRAINT [PrimaryKey_311d74b0-16e9-4f21-98d5-f168f335934b] PRIMARY KEY CLUSTERED ([SportID] ASC)
);