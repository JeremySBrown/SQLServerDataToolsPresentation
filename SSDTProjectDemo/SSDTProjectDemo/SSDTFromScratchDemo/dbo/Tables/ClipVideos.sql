﻿CREATE TABLE [dbo].[ClipVideos] (
    [ClipVideoID]       INT              IDENTITY (1, 1) NOT NULL,
    [ClipVideoKey]      UNIQUEIDENTIFIER CONSTRAINT [DF_ClipVideo_ClipVideoKey] DEFAULT (newid()) NOT NULL,
    [RawVideoID]        INT              NULL,
    [ClipTypeID]        INT              CONSTRAINT [DF_ClipVideo_ClipTypeID] DEFAULT ((0)) NOT NULL,
    [Action]            NVARCHAR (255)   CONSTRAINT [DF_ClipVideo_ActionID] DEFAULT ((0)) NOT NULL,
    [Title]             NVARCHAR (255)   NULL,
    [Notes]             NTEXT            NULL,
    [ActivityDate]      DATETIME         NULL,
    [ClipDate]          DATETIME         CONSTRAINT [DF_ClipVideo_ClipDate] DEFAULT (getdate()) NOT NULL,
    [StorageLocation]   NVARCHAR (255)   NULL,
    [StorageContainer]  NVARCHAR (255)   NULL,
    [StorageKey]        NVARCHAR (255)   NULL,
    [FrameCount]        INT              CONSTRAINT [DF_ClipVideo_FrameCount] DEFAULT ((150)) NOT NULL,
    [FreeToTelestrate]  BIT              CONSTRAINT [DF_ClipVideo_FreeToTelestrate] DEFAULT ((0)) NOT NULL,
    [EncodingStatus]    INT              CONSTRAINT [DF_ClipVideo_EncodingStatus] DEFAULT ((0)) NOT NULL,
    [Deleted]           BIT              CONSTRAINT [DF_ClipVideo_Deleted] DEFAULT ((0)) NOT NULL,
    [IsPrivate]         BIT              CONSTRAINT [ColumnDefault_cc055340-6794-4d4e-905d-bdf35e8b37e7] DEFAULT ((0)) NULL,
    [Sport]             NVARCHAR (255)   NULL,
    [EncodeCommand]     NVARCHAR (255)   NULL,
    [EncodeSubmit]      DATETIME         NULL,
    [EncodeStart]       DATETIME         NULL,
    [EncodeComplete]    DATETIME         NULL,
    [Latitude]          DECIMAL (11, 9)  NULL,
    [Longitude]         DECIMAL (12, 9)  NULL,
    [OwnerID]           UNIQUEIDENTIFIER NULL,
    [ClippedByUserID]   UNIQUEIDENTIFIER NULL,
    [CoachInstructorID] UNIQUEIDENTIFIER NULL,
    [OrganizationID]    UNIQUEIDENTIFIER NULL,
    [IsPublic]          BIT              DEFAULT 0 NULL,
    [SourceAppID]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ClipVideo] PRIMARY KEY CLUSTERED ([ClipVideoID] ASC),
    CONSTRAINT [FK_ClipVideos_VstratorApps] FOREIGN KEY ([SourceAppID]) REFERENCES [dbo].[VstratorApps] ([ID])
);