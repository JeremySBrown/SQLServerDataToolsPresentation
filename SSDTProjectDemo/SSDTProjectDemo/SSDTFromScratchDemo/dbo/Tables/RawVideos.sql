﻿CREATE TABLE [dbo].[RawVideos] (
    [RawVideoID]        INT              IDENTITY (1, 1) NOT NULL,
    [RawVideoKey]       UNIQUEIDENTIFIER CONSTRAINT [DF_RawVideo_RawVideoKey] DEFAULT (newid()) NOT NULL,
    [Action]            NVARCHAR (255)   CONSTRAINT [DF_RawVideo_ActionID] DEFAULT ((0)) NOT NULL,
    [Title]             NVARCHAR (255)   NULL,
    [Notes]             NTEXT            NULL,
    [Duration]          TIME (7)         NULL,
    [FormatMetaData]    NVARCHAR (255)   NULL,
    [ActivityDate]      DATETIME         CONSTRAINT [DF_RawVideo_ActivityDate] DEFAULT (getdate()) NOT NULL,
    [UploadDate]        DATETIME         CONSTRAINT [DF_RawVideo_UploadDate] DEFAULT (getdate()) NOT NULL,
    [StorageLocation]   NVARCHAR (255)   NULL,
    [StorageContainer]  NVARCHAR (255)   NULL,
    [StorageKey]        NVARCHAR (255)   NULL,
    [Deleted]           BIT              CONSTRAINT [DF_RawVideo_Deleted] DEFAULT ((0)) NOT NULL,
    [EncodingStatus]    INT              CONSTRAINT [DF_RawVideo_VideoStatus] DEFAULT ((0)) NOT NULL,
    [IsPrivate]         BIT              CONSTRAINT [ColumnDefault_57359f2c-a54e-4ed4-b1b4-9d8c7d7373e6] DEFAULT ((0)) NULL,
    [Sport]             NVARCHAR (255)   NULL,
    [Latitude]          DECIMAL (11, 9)  NULL,
    [Longitude]         DECIMAL (12, 9)  NULL,
    [OwnerID]           UNIQUEIDENTIFIER NULL,
    [UploadedByUserID]  UNIQUEIDENTIFIER NULL,
    [CoachInstructorID] UNIQUEIDENTIFIER NULL,
    [OrganizationID]    UNIQUEIDENTIFIER NULL,
    [IsPublic]          BIT              DEFAULT 0 NULL,
    [SourceAppID]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_RawVideo] PRIMARY KEY CLUSTERED ([RawVideoID] ASC),
    CONSTRAINT [FK_RawVideos_VstratorApps] FOREIGN KEY ([SourceAppID]) REFERENCES [dbo].[VstratorApps] ([ID])
);