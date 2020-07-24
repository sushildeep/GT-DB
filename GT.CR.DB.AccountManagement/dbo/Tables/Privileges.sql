CREATE TABLE [dbo].[Privileges] (
    [PrivilegeID]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [PrivilegeCode]         NVARCHAR (500) NOT NULL,
    [PrivilegeName]         VARCHAR (200)  NOT NULL,
    [UniqueIdentifier]      NVARCHAR (MAX) NULL,
    [BusinessModuleID]      BIGINT         NOT NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [UpdatedBy]             NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    [status]                VARCHAR (10)   DEFAULT ('ACTIVE') NULL,
    [IscondtionalPrivilege] INT            NULL,
    [Description]           VARCHAR (MAX)  NULL,
    CONSTRAINT [PK_dbo.Privileges] PRIMARY KEY CLUSTERED ([PrivilegeID] ASC),
    CONSTRAINT [FK_dbo.Privileges_dbo.BusinessModules_BusinessModuleID] FOREIGN KEY ([BusinessModuleID]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleID]) ON DELETE CASCADE,
    CONSTRAINT [Previleges_PrevilegeCode_unique] UNIQUE NONCLUSTERED ([PrivilegeCode] ASC)
);

