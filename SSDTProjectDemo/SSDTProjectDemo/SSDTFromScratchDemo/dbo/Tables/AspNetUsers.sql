﻿CREATE TABLE [dbo].[AspNetUsers] (
    [Id]                                     NVARCHAR (128)   NOT NULL,
    [UserName]                               NVARCHAR (128)   NULL,
    [PasswordHash]                           NVARCHAR (MAX)   NULL,
    [SecurityStamp]                          NVARCHAR (MAX)   NULL,
    [Discriminator]                          NVARCHAR (128)   NOT NULL,
    [ApplicationId]                          UNIQUEIDENTIFIER NOT NULL,
    [LegacyPasswordHash]                     NVARCHAR (MAX)   NULL,
    [LoweredUserName]                        NVARCHAR (256)   NOT NULL,
    [MobileAlias]                            NVARCHAR (16)    DEFAULT (NULL) NULL,
    [IsAnonymous]                            BIT              DEFAULT ((0)) NOT NULL,
    [LastActivityDate]                       DATETIME2 (7)    NOT NULL,
    [MobilePIN]                              NVARCHAR (16)    NULL,
    [Email]                                  NVARCHAR (256)   NULL,
    [LoweredEmail]                           NVARCHAR (256)   NULL,
    [PasswordQuestion]                       NVARCHAR (256)   NULL,
    [PasswordAnswer]                         NVARCHAR (128)   NULL,
    [IsApproved]                             BIT              NOT NULL,
    [IsLockedOut]                            BIT              NOT NULL,
    [CreateDate]                             DATETIME2 (7)    NOT NULL,
    [LastLoginDate]                          DATETIME2 (7)    NOT NULL,
    [LastPasswordChangedDate]                DATETIME2 (7)    NOT NULL,
    [LastLockoutDate]                        DATETIME2 (7)    NOT NULL,
    [FailedPasswordAttemptCount]             INT              NOT NULL,
    [FailedPasswordAttemptWindowStart]       DATETIME2 (7)    NOT NULL,
    [FailedPasswordAnswerAttemptCount]       INT              NOT NULL,
    [FailedPasswordAnswerAttemptWindowStart] DATETIME2 (7)    NOT NULL,
    [Comment]                                NTEXT            NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);