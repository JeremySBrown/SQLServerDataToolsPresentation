CREATE TABLE [dbo].[Tokens] (
    [TokenID]             INT              IDENTITY (1, 1) NOT NULL,
    [TokenKey]            UNIQUEIDENTIFIER CONSTRAINT [DF_Tokens_TokenKey] DEFAULT (newid()) NOT NULL,
    [SerialNumber]        UNIQUEIDENTIFIER CONSTRAINT [DF_Tokens_SerialNumber] DEFAULT (newid()) NOT NULL,
    [SiteID]              INT              NULL,
    [PurchasedByUserID]   INT              NULL,
    [AthleteUsedOnUserID] INT              NULL,
    [RedeemedByUserID]    INT              NULL,
    [TokenTypeID]         INT              NULL,
    [PurchasedDate]       DATETIME         CONSTRAINT [DF_Tokens_PurchasedDate] DEFAULT (getdate()) NOT NULL,
    [RedeemedDateTime]    DATETIME         NULL,
    [RedeemedIP]          NVARCHAR (255)   NULL,
    CONSTRAINT [PK_Tokens] PRIMARY KEY CLUSTERED ([TokenID] ASC)
);