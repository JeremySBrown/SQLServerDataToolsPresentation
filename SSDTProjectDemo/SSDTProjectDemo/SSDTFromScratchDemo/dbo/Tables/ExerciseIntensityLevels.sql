CREATE TABLE [dbo].[ExerciseIntensityLevels] (
    [ExerciseID]     UNIQUEIDENTIFIER NOT NULL,
    [IntensityLevel] INT              NOT NULL,
    [Duration]       DECIMAL (7, 3)   NULL,
    [Reps]           INT              NULL,
    [Sets]           INT              NULL,
    [Resistance]     NVARCHAR (50)    NULL,
    CONSTRAINT [PK_ExerciseIntensityLevels] PRIMARY KEY CLUSTERED ([ExerciseID] ASC, [IntensityLevel] ASC),
    CONSTRAINT [FK_ExerciseIntensityLevels_Exercises] FOREIGN KEY ([ExerciseID]) REFERENCES [dbo].[Exercises] ([ID]) ON DELETE CASCADE
);