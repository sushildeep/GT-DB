CREATE TABLE [dbo].[TeamSubAreaMapping] (
    [TeamSubAreaMappingID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OfficeLocationID]     BIGINT         NOT NULL,
    [TeamID]               BIGINT         NOT NULL,
    [SubAreaInfoID]        BIGINT         NOT NULL,
    [Status]               VARCHAR (15)   NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDate]          DATETIME       NULL,
    [LastModifiedBy]       NVARCHAR (MAX) NULL,
    [LastModifiedDate]     DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([TeamSubAreaMappingID] ASC),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([SubAreaInfoID]) REFERENCES [dbo].[SubAreaInfo] ([SubAreaInfoID]),
    FOREIGN KEY ([TeamID]) REFERENCES [dbo].[Teams] ([TeamID])
);

