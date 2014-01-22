CREATE TABLE [dbo].[MarketingDemographics] (
    [ID]          INT              NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [ProfileID]   UNIQUEIDENTIFIER NOT NULL,
    [ProfileType] INT              NOT NULL,
    [DataAction]  INT              NOT NULL,
    [DataPoint]   NVARCHAR (100)   NOT NULL,
    [DataValue]   NVARCHAR (255)   NOT NULL,
    [DateCreated] DATETIME2 (7)    DEFAULT getdate() NOT NULL
);