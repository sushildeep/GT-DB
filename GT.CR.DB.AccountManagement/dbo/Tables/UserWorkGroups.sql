CREATE TABLE [dbo].[UserWorkGroups] (
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [UpdatedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    [UserWorkGroupID]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [WorkGroupCode]    VARCHAR (10)   NULL,
    [UUID]             VARCHAR (10)   NULL,
    PRIMARY KEY CLUSTERED ([UserWorkGroupID] ASC),
    CONSTRAINT [UserWorkGroups_uuid_fk] FOREIGN KEY ([UUID]) REFERENCES [dbo].[Users] ([UUID]),
    CONSTRAINT [UserWorkGroups_WorkGroupCode_fk] FOREIGN KEY ([WorkGroupCode]) REFERENCES [dbo].[WorkGroups] ([WorkGroupCode])
);

