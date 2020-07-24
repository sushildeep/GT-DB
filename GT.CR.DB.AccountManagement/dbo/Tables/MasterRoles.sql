CREATE TABLE [dbo].[MasterRoles] (
    [MasterRoleId] INT          IDENTITY (1, 1) NOT NULL,
    [RoleCode]     VARCHAR (10) NULL,
    [RoleName]     VARCHAR (50) NULL,
    [Status]       VARCHAR (10) DEFAULT ('ACTIVE') NULL,
    PRIMARY KEY CLUSTERED ([MasterRoleId] ASC),
    UNIQUE NONCLUSTERED ([RoleCode] ASC),
    UNIQUE NONCLUSTERED ([RoleCode] ASC),
    UNIQUE NONCLUSTERED ([RoleName] ASC),
    UNIQUE NONCLUSTERED ([RoleName] ASC)
);

