CREATE TABLE [dbo].[ContentSets] (
    [ID]              UNIQUEIDENTIFIER NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [SetName]         NVARCHAR (100)   NOT NULL,
    [Description]     NVARCHAR (MAX)   NULL,
    [InAppPurchaseID] NVARCHAR (100)   NULL,
    [Price]           DECIMAL (5, 2)   NULL
);