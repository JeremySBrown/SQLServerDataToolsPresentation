CREATE TABLE [dbo].[Workouts] (
    [ID]             UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
    [WorkoutName]    NVARCHAR (100)   NOT NULL,
    [IntensityLevel] INT              NOT NULL,
    [Description]    NVARCHAR (MAX)   NULL,
    [Category]       NVARCHAR (50)    NULL,
    CONSTRAINT [PK_Workouts] PRIMARY KEY CLUSTERED ([ID] ASC)
);