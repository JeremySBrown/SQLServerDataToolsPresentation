CREATE TABLE [dbo].[Tips] (
    [TipID]        INT            IDENTITY (1, 1) NOT NULL,
    [Title]        NVARCHAR (200) NOT NULL,
    [Details]      NVARCHAR (MAX) NOT NULL,
    [DisplayOrder] INT            CONSTRAINT [ColumnDefault_0e1f9e56-2ca0-4350-8d97-d4e0e6921eef] DEFAULT ((0)) NOT NULL,
    [Publish]      BIT            CONSTRAINT [ColumnDefault_e6b3288c-6a90-4f22-aee9-f7043a8b330d] DEFAULT ((1)) NOT NULL,
    [DateCreated]  DATETIME       CONSTRAINT [ColumnDefault_b52768a3-8247-4c21-ae0d-410e8eaada7f] DEFAULT (getdate()) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [ColumnDefault_75516eea-14f6-4a44-a37d-a961f8f338e0] DEFAULT (getdate()) NOT NULL,
    [ThumbUrl]     NVARCHAR (255) NULL,
    [VideoUrl]     NVARCHAR (255) NULL,
    CONSTRAINT [PrimaryKey_f5c9227f-f0ef-4eb0-a94e-112f8978a019] PRIMARY KEY CLUSTERED ([TipID] ASC)
);