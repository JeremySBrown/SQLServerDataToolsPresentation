CREATE TABLE [dbo].[AthleteActions] (
    [ActionID]   INT           IDENTITY (1, 1) NOT NULL,
    [ActionText] NVARCHAR (50) NULL,
    [Active]     BIT           CONSTRAINT [DF_AthleteActions_Active] DEFAULT ((1)) NOT NULL,
    [SortOrder]  INT           CONSTRAINT [DF_AthleteActions_SortOrder] DEFAULT ((0)) NOT NULL,
    [SportID]    INT           CONSTRAINT [ColumnDefault_20ed8681-cb2a-4080-bfb1-5798c27a892c] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_AthleteActions] PRIMARY KEY CLUSTERED ([ActionID] ASC),
    CONSTRAINT [FK_AthleteActions_ToSports] FOREIGN KEY ([SportID]) REFERENCES [dbo].[Sports] ([SportID])
);