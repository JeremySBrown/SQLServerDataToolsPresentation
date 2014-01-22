CREATE TABLE [dbo].[CreditCardCharges] (
    [Id]                    UNIQUEIDENTIFIER DEFAULT newid() NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [UserProfileId]         UNIQUEIDENTIFIER NOT NULL,
    [DateCharged]           DATETIME2 (7)    DEFAULT getdate() NOT NULL,
    [ChargeAmount]          MONEY            NOT NULL,
    [PaymentProcessor]      NVARCHAR (50)    NOT NULL,
    [ProcessorChargeId]     NVARCHAR (50)    NULL,
    [ProcessorCustomerId]   NVARCHAR (50)    NULL,
    [ProcessorErrorType]    NVARCHAR (25)    NULL,
    [ProcessorErrorCode]    NVARCHAR (25)    NULL,
    [ProcessorErrorMessage] NVARCHAR (500)   NULL,
    CONSTRAINT [FK_CreditCardCharges_UserProfiles] FOREIGN KEY ([UserProfileId]) REFERENCES [dbo].[UserProfiles] ([ID])
);