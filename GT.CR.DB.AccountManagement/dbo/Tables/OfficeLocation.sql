CREATE TABLE [dbo].[OfficeLocation] (
    [OfficeLocationID]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [AccountInfoID]      BIGINT         NOT NULL,
    [OfficeLocationName] NVARCHAR (MAX) NULL,
    [OfficeLocationCode] VARCHAR (15)   NULL,
    [Description]        NVARCHAR (MAX) NULL,
    [Status]             VARCHAR (15)   NULL,
    [CreatedBy]          NVARCHAR (MAX) NULL,
    [CreatedDate]        DATETIME       NULL,
    [LastModifiedBy]     NVARCHAR (MAX) NULL,
    [LastModifiedDate]   DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([OfficeLocationID] ASC),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID])
);

