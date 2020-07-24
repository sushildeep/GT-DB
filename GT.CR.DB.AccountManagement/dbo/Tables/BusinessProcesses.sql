CREATE TABLE [dbo].[BusinessProcesses] (
    [BusinessProcessID]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [BusinessProcessName] VARCHAR (200)  NOT NULL,
    [CreatedBy]           NVARCHAR (MAX) NULL,
    [CreatedDate]         DATETIME       NULL,
    [UpdatedBy]           NVARCHAR (MAX) NULL,
    [LastModifiedDate]    DATETIME       NULL,
    [BusinessProcessCode] VARCHAR (10)   NOT NULL,
    CONSTRAINT [PK_dbo.BusinessProcesses] PRIMARY KEY CLUSTERED ([BusinessProcessID] ASC),
    CONSTRAINT [BusinessProcessCode_Unique] UNIQUE NONCLUSTERED ([BusinessProcessCode] ASC)
);

