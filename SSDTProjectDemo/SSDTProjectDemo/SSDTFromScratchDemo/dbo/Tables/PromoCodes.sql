CREATE TABLE [dbo].[PromoCodes] (
    [PromoCodeID]   INT            IDENTITY (1, 1) NOT NULL,
    [PromoCodeText] NVARCHAR (25)  NOT NULL,
    [PlanID]        INT            CONSTRAINT [ColumnDefault_ba2f8ef2-83bc-4b4c-94c6-c659c64ae164] DEFAULT ((0)) NOT NULL,
    [CodeType]      INT            CONSTRAINT [ColumnDefault_a37e3360-b065-45ba-b352-efd229dcd6f0] DEFAULT ((0)) NOT NULL,
    [StartDate]     DATETIME       NOT NULL,
    [EndDate]       DATETIME       NOT NULL,
    [Duration]      INT            CONSTRAINT [ColumnDefault_0aa93a42-75df-44c2-baf9-f1f055e16149] DEFAULT ((0)) NOT NULL,
    [UsageLimit]    INT            CONSTRAINT [ColumnDefault_c78e298b-721c-4f78-9658-32def877dcae] DEFAULT ((-1)) NOT NULL,
    [Amount]        DECIMAL (7, 2) CONSTRAINT [ColumnDefault_cf9396e5-7809-4e7c-88c0-717b8280ffa9] DEFAULT ((0)) NOT NULL,
    [Active]        BIT            CONSTRAINT [ColumnDefault_eb70687e-9520-4e60-9868-406fe67a594e] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PrimaryKey_a6448f77-e55f-4399-9cfc-3a2c1b9355a4] PRIMARY KEY CLUSTERED ([PromoCodeID] ASC)
);