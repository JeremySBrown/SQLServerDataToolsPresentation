CREATE TABLE [dbo].[SecurityQuestions] (
    [QuestionID]   INT            IDENTITY (1, 1) NOT NULL,
    [QuestionText] NVARCHAR (255) NULL,
    CONSTRAINT [PK_SecurityQuestions] PRIMARY KEY CLUSTERED ([QuestionID] ASC)
);