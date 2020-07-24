CREATE TABLE [dbo].[BusinessModuleInfoes] (
    [BusinessModuleInfoID]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [BusinessProcessInfoID] BIGINT         NOT NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [UpdatedBy]             NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    [BusinessModuleCode]    VARCHAR (10)   NOT NULL,
    [AccountAbbreviation]   VARCHAR (100)  NULL,
    [ModuleURLKey]          VARCHAR (50)   NULL,
    CONSTRAINT [PK_dbo.BusinessModuleInfoes] PRIMARY KEY CLUSTERED ([BusinessModuleInfoID] ASC),
    CONSTRAINT [BusinessModuleCode_fk] FOREIGN KEY ([BusinessModuleCode]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleCode]),
    CONSTRAINT [FK_dbo.BusinessModuleInfoes_dbo.BusinessProcessInfoes_BusinessProcessInfoID] FOREIGN KEY ([BusinessProcessInfoID]) REFERENCES [dbo].[BusinessProcessInfoes] ([BusinessProcessInfoID]) ON DELETE CASCADE
);

