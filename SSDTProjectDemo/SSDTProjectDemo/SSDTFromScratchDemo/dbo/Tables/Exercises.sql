CREATE TABLE [dbo].[Exercises] (
    [ID]                UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [ExerciseName]      NVARCHAR (100)   NOT NULL,
    [Description]       NVARCHAR (MAX)   NULL,
    [RelatedClipType]   INT              NULL,
    [RelatedClipID]     INT              NULL,
    [RelatedVideoID]    INT              NULL,
    [EquipmentRequired] NVARCHAR (2000)  NULL,
    CONSTRAINT [PK_Exercises] PRIMARY KEY CLUSTERED ([ID] ASC)
);