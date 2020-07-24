CREATE TABLE [dbo].[UserLocationRole] (
    [UserLocationRoleID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserID]             BIGINT         NOT NULL,
    [OfficeLocationID]   BIGINT         NOT NULL,
    [RoleID]             BIGINT         NOT NULL,
    [Status]             VARCHAR (15)   NULL,
    [CreatedBy]          NVARCHAR (MAX) NULL,
    [CreatedDate]        DATETIME       NULL,
    [LastModifiedBy]     NVARCHAR (MAX) NULL,
    [LastModifiedDate]   DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([UserLocationRoleID] ASC),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

