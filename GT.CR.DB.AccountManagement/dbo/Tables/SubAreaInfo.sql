CREATE TABLE [dbo].[SubAreaInfo] (
    [SubAreaInfoID]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [LocationAreaID]   BIGINT         NOT NULL,
    [SubAreaCode]      NVARCHAR (MAX) NOT NULL,
    [SubAreaName]      NVARCHAR (MAX) NOT NULL,
    [Description]      NVARCHAR (MAX) NULL,
    [Status]           VARCHAR (15)   NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [LastModifiedBy]   NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([SubAreaInfoID] ASC),
    FOREIGN KEY ([LocationAreaID]) REFERENCES [dbo].[LocationArea] ([LocationAreaID])
);

