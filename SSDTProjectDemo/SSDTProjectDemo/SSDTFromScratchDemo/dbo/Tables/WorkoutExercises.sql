CREATE TABLE [dbo].[WorkoutExercises] (
    [WorkoutID]    UNIQUEIDENTIFIER NOT NULL,
    [ExerciseID]   UNIQUEIDENTIFIER NOT NULL,
    [DisplayOrder] INT              DEFAULT 0 NOT NULL,
    CONSTRAINT [PK_WorkoutExercises] PRIMARY KEY CLUSTERED ([WorkoutID] ASC, [ExerciseID] ASC),
    CONSTRAINT [FK_WorkoutExercises_Exercises] FOREIGN KEY ([ExerciseID]) REFERENCES [dbo].[Exercises] ([ID]),
    CONSTRAINT [FK_WorkoutExercises_Workouts] FOREIGN KEY ([WorkoutID]) REFERENCES [dbo].[Workouts] ([ID])
);