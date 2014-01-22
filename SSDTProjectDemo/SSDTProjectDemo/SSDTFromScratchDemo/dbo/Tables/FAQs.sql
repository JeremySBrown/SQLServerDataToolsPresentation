CREATE TABLE [dbo].[FAQs] (
    [FAQID]        INT            IDENTITY (1, 1) NOT NULL,
    [Title]        NVARCHAR (200) NOT NULL,
    [Details]      NVARCHAR (MAX) NOT NULL,
    [DisplayOrder] INT            CONSTRAINT [DF_FAQs_DisplayOrder] DEFAULT ((0)) NOT NULL,
    [Publish]      BIT            CONSTRAINT [DF_Table_1_Publich] DEFAULT ((1)) NOT NULL,
    [DateCreated]  DATETIME       CONSTRAINT [DF_FAQs_DateCreated] DEFAULT (getdate()) NOT NULL,
    [DateModified] DATETIME       CONSTRAINT [DF_FAQs_DateModified] DEFAULT (getdate()) NOT NULL,
    [CategoryID]   INT            NULL,
    CONSTRAINT [PK_FAQs] PRIMARY KEY CLUSTERED ([FAQID] ASC)
);