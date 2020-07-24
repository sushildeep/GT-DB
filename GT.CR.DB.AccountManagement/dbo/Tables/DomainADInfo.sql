CREATE TABLE [dbo].[DomainADInfo] (
    [DomainADInfoID]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [Domain]             VARCHAR (200)  NOT NULL,
    [Url]                VARCHAR (200)  NOT NULL,
    [Remarks]            VARCHAR (200)  NOT NULL,
    [CreatedDate]        DATETIME       NOT NULL,
    [CreatedBy]          NVARCHAR (MAX) NOT NULL,
    [UpdatedDate]        DATETIME       NULL,
    [UpdatedBy]          NVARCHAR (MAX) NULL,
    [DomainIP]           NVARCHAR (200) NULL,
    [DomainUserName]     NVARCHAR (200) NULL,
    [DomainUserPassword] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([DomainADInfoID] ASC)
);

