CREATE TABLE [dbo].[WorkGroups] (
    [WorkGroupName]        VARCHAR (200) NOT NULL,
    [WorkGroupType]        VARCHAR (200) NOT NULL,
    [BusinessModuleInfoID] BIGINT        NULL,
    [CreatedBy]            VARCHAR (MAX) NULL,
    [CreatedDate]          DATETIME      NULL,
    [UpdatedBy]            VARCHAR (MAX) NULL,
    [LastModifiedDate]     DATETIME      NULL,
    [WorkGroupID]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [WorkGroupCode]        VARCHAR (10)  NOT NULL,
    [AccountCode]          VARCHAR (10)  NULL,
    [uuid]                 VARCHAR (10)  NULL,
    PRIMARY KEY CLUSTERED ([WorkGroupID] ASC),
    CONSTRAINT [WorkGroups_AccountCode_fk] FOREIGN KEY ([AccountCode]) REFERENCES [dbo].[AccountInfoes] ([AccountCode]),
    CONSTRAINT [WorkGroups_BusinessModuleInfoID_fk] FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    CONSTRAINT [WorkGroups_uuid_fk] FOREIGN KEY ([uuid]) REFERENCES [dbo].[Users] ([UUID]),
    CONSTRAINT [WorkGroupCode_Unique] UNIQUE NONCLUSTERED ([WorkGroupCode] ASC)
);

