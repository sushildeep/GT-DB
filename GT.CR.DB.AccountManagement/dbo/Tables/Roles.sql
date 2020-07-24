CREATE TABLE [dbo].[Roles] (
    [RoleID]               BIGINT         IDENTITY (1, 1) NOT NULL,
    [RoleName]             VARCHAR (200)  NOT NULL,
    [Description]          NVARCHAR (MAX) NULL,
    [AccountID]            BIGINT         NOT NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDate]          DATETIME       NULL,
    [UpdatedBy]            NVARCHAR (MAX) NULL,
    [LastModifiedDate]     DATETIME       NULL,
    [MasterRoleId]         INT            NULL,
    [BusinessModuleInfoID] BIGINT         NOT NULL,
    CONSTRAINT [PK_dbo.Roles] PRIMARY KEY CLUSTERED ([RoleID] ASC),
    FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    FOREIGN KEY ([MasterRoleId]) REFERENCES [dbo].[MasterRoles] ([MasterRoleId]),
    CONSTRAINT [FK_dbo.Roles_dbo.AccountInfoes_AccountID] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID]) ON DELETE CASCADE
);

