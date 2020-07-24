CREATE TABLE [dbo].[UserPrivileges] (
    [UserPrivilegeID]                BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserID]                         BIGINT         NOT NULL,
    [AccountCode]                    VARCHAR (10)   NOT NULL,
    [Privilege_BusinessModuleInfoID] BIGINT         NOT NULL,
    [PrivilegeCode]                  NVARCHAR (500) NOT NULL,
    [CreatedBy]                      NVARCHAR (MAX) NULL,
    [CreatedDate]                    DATETIME       NULL,
    [UpdatedBy]                      NVARCHAR (MAX) NULL,
    [LastModifiedDate]               DATETIME       NULL,
    [BusinessModuleCode]             VARCHAR (10)   NULL,
    [status]                         VARCHAR (10)   DEFAULT ('ACTIVE') NULL,
    [IscondtionalPrivilege]          INT            NULL,
    CONSTRAINT [PK_dbo.UserPrivileges] PRIMARY KEY CLUSTERED ([UserPrivilegeID] ASC),
    FOREIGN KEY ([BusinessModuleCode]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleCode]),
    FOREIGN KEY ([BusinessModuleCode]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleCode]),
    CONSTRAINT [FK_dbo.UserPrivileges_dbo.Users_UserID] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE,
    CONSTRAINT [UserPrevileges_PrevilegeCode_FK] FOREIGN KEY ([PrivilegeCode]) REFERENCES [dbo].[Privileges] ([PrivilegeCode]),
    CONSTRAINT [UserPrivileges_AccountCode_FK] FOREIGN KEY ([AccountCode]) REFERENCES [dbo].[AccountInfoes] ([AccountCode]),
    CONSTRAINT [UserPrivileges_BusinessModuleInfo_FK] FOREIGN KEY ([Privilege_BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID])
);

