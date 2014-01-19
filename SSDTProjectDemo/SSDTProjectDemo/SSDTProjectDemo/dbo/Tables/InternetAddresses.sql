CREATE TABLE [dbo].[InternetAddresses] (
    [Id]          INT           IDENTITY (1, 1) NOT NULL,
    [CustomerId]  INT           NOT NULL,
    [AddressType] INT           NULL,
    [Address]     NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_InternetAddresses_Customers] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id]),
    CONSTRAINT [FK_InternetAddresses_InternetAddressTypes] FOREIGN KEY ([AddressType]) REFERENCES [dbo].[InternetAddressTypes] ([Id])
);

