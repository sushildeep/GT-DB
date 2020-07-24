CREATE TABLE [dbo].[LocationArea] (
    [LocationAreaID]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [OfficeLocationID] BIGINT         NOT NULL,
    [AreaCode]         NVARCHAR (MAX) NOT NULL,
    [AreaName]         NVARCHAR (MAX) NULL,
    [Description]      NVARCHAR (MAX) NULL,
    [Status]           VARCHAR (15)   NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [LastModifiedBy]   NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([LocationAreaID] ASC),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID])
);

