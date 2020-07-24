CREATE TABLE [dbo].[BusinessModules] (
    [BusinessModuleID]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [BusinessModuleName] NVARCHAR (MAX) NULL,
    [BusinessProcessID]  BIGINT         NOT NULL,
    [CreatedBy]          NVARCHAR (MAX) NULL,
    [CreatedDate]        DATETIME       NULL,
    [UpdatedBy]          NVARCHAR (MAX) NULL,
    [LastModifiedDate]   DATETIME       NULL,
    [LogoPath]           NVARCHAR (MAX) NULL,
    [BusinessModuleCode] VARCHAR (10)   NOT NULL,
    CONSTRAINT [PK_dbo.BusinessModules] PRIMARY KEY CLUSTERED ([BusinessModuleID] ASC),
    CONSTRAINT [FK_dbo.BusinessModules_dbo.BusinessProcesses_BusinessProcessID] FOREIGN KEY ([BusinessProcessID]) REFERENCES [dbo].[BusinessProcesses] ([BusinessProcessID]) ON DELETE CASCADE,
    CONSTRAINT [BusinessModules_Unique] UNIQUE NONCLUSTERED ([BusinessModuleCode] ASC)
);

