CREATE TABLE [dbo].[CoachRequestContents] (
    [ID]                          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL PRIMARY KEY CLUSTERED ([ID] ASC),
    [CoachRequestID]              UNIQUEIDENTIFIER NOT NULL,
    [ClipVideoID]                 INT              NOT NULL,
    [SessionVideoID]              INT              NULL,
    [CoachRequestContentStatusID] INT              NOT NULL,
    [DateSessionAdded]            DATETIME2 (7)    NULL,
    [DateCreated]                 DATETIME2 (7)    NOT NULL,
    [DateModified]                DATETIME2 (7)    NOT NULL,
    CONSTRAINT [FK_CoachRequestContents_ToClipVideos] FOREIGN KEY ([ClipVideoID]) REFERENCES [dbo].[ClipVideos] ([ClipVideoID]),
    CONSTRAINT [FK_CoachRequestContents_ToCoachRequests] FOREIGN KEY ([CoachRequestID]) REFERENCES [dbo].[CoachRequests] ([ID]),
    CONSTRAINT [FK_CoachRequestContents_ToSessionVideos] FOREIGN KEY ([SessionVideoID]) REFERENCES [dbo].[SessionVideos] ([SessionVideoID])
);