CREATE TABLE [dbo].[RolePrivileges] (
    [RolePrivilegeID]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleID]                BIGINT         NOT NULL,
    [AccountCode]           VARCHAR (10)   NOT NULL,
    [BusinessProcessInfoID] BIGINT         NOT NULL,
    [BusinessModuleInfoID]  BIGINT         NOT NULL,
    [PrivilegeCode]         NVARCHAR (500) NOT NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [UpdatedBy]             NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    [status]                VARCHAR (10)   DEFAULT ('ACTIVE') NULL,
    [BusinessModuleCode]    VARCHAR (10)   NULL,
    [IscondtionalPrivilege] INT            NULL,
    CONSTRAINT [PK_dbo.RolePrivileges] PRIMARY KEY CLUSTERED ([RolePrivilegeID] ASC),
    FOREIGN KEY ([BusinessModuleCode]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleCode]),
    FOREIGN KEY ([BusinessModuleCode]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleCode]),
    CONSTRAINT [FK_dbo.RolePrivileges_dbo.Roles_RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]) ON DELETE CASCADE,
    CONSTRAINT [RolePrevileges_PrevilegeCode_FK] FOREIGN KEY ([PrivilegeCode]) REFERENCES [dbo].[Privileges] ([PrivilegeCode]),
    CONSTRAINT [RolePrivileges_AccountCode_FK] FOREIGN KEY ([AccountCode]) REFERENCES [dbo].[AccountInfoes] ([AccountCode]),
    CONSTRAINT [RolePrivileges_BusinessModuleInfo_FK] FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    CONSTRAINT [RolePrivileges_BusinessProcessInfo_FK] FOREIGN KEY ([BusinessProcessInfoID]) REFERENCES [dbo].[BusinessProcessInfoes] ([BusinessProcessInfoID])
);

