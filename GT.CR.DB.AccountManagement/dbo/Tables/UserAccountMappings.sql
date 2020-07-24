CREATE TABLE [dbo].[UserAccountMappings] (
    [UserLocationModuleMappingID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserID]                      BIGINT         NOT NULL,
    [OfficeLocationID]            BIGINT         NOT NULL,
    [AccountInfoID]               BIGINT         NOT NULL,
    [BusinessModuleInfoID]        BIGINT         NULL,
    [ModuleToggleOrder]           INT            NULL,
    [DeployemntTagName]           NVARCHAR (MAX) NULL,
    [Status]                      VARCHAR (15)   NULL,
    [CreatedBy]                   NVARCHAR (MAX) NULL,
    [CreatedDate]                 DATETIME       NULL,
    [LastModifiedBy]              NVARCHAR (MAX) NULL,
    [LastModifiedDate]            DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([UserLocationModuleMappingID] ASC),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID]),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID]),
    FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

