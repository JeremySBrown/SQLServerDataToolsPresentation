CREATE TABLE [dbo].[LookupItems] (
    [Id]              UNIQUEIDENTIFIER DEFAULT newid() NOT NULL PRIMARY KEY CLUSTERED ([Id] ASC),
    [ParentId]        UNIQUEIDENTIFIER NULL,
    [LookupItemType]  NVARCHAR (100)   NOT NULL,
    [ItemValueString] NVARCHAR (255)   NOT NULL,
    [ItemText]        NVARCHAR (255)   NOT NULL,
    [ItemValueType]   NVARCHAR (100)   NOT NULL,
    [SortOrder]       INT              NOT NULL,
    CONSTRAINT [FK_ChildLookupItems_ParentLookupItems] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[LookupItems] ([Id])
);