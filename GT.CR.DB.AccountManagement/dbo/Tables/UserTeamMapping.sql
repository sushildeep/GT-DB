CREATE TABLE [dbo].[UserTeamMapping] (
    [UserTeamMappingID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TeamID]            BIGINT         NOT NULL,
    [UUID]              VARCHAR (10)   NOT NULL,
    [AccountCode]       VARCHAR (10)   NOT NULL,
    [TeamNodeType]      NVARCHAR (MAX) NULL,
    [ParentOrChildID]   VARCHAR (10)   NULL,
    [Status]            NVARCHAR (MAX) NULL,
    [CreatedBy]         NVARCHAR (MAX) NULL,
    [CreatedDate]       DATETIME       NULL,
    [UpdatedBy]         NVARCHAR (MAX) NULL,
    [LastModifiedDate]  DATETIME       NULL,
    [OfficeLocationID]  BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([UserTeamMappingID] ASC),
    FOREIGN KEY ([AccountCode]) REFERENCES [dbo].[AccountInfoes] ([AccountCode]),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([TeamID]) REFERENCES [dbo].[Teams] ([TeamID]),
    FOREIGN KEY ([UUID]) REFERENCES [dbo].[Users] ([UUID])
);

