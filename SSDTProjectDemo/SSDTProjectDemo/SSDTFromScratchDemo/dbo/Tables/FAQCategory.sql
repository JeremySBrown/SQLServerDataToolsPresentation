CREATE TABLE [dbo].[FAQCategory] (
    [CategoryID]   INT            IDENTITY (1, 1) NOT NULL,
    [Title]        NVARCHAR (255) NOT NULL,
    [Description]  NVARCHAR (255) NOT NULL,
    [DisplayOrder] INT            CONSTRAINT [ColumnDefault_4f866c4b-7368-48db-a2cc-eb6f8136462a] DEFAULT ((0)) NOT NULL,
    [Publish]      BIT            CONSTRAINT [ColumnDefault_b41db58f-d52b-483e-b0e4-813f568672cb] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PrimaryKey_e71c06a6-2475-44aa-8542-376c547839f1] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);