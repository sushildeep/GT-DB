CREATE TABLE [dbo].[Users] (
    [UserID]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [First_Name]       VARCHAR (200)  NOT NULL,
    [Last_Name]        NVARCHAR (MAX) NULL,
    [Middle_Name]      NVARCHAR (MAX) NULL,
    [Photo]            NVARCHAR (MAX) NULL,
    [DOB]              DATETIME2 (7)  NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [UpdatedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    [UserName]         NVARCHAR (200) NOT NULL,
    [Suffix]           VARCHAR (200)  NULL,
    [Prefix]           VARCHAR (200)  NULL,
    [gender]           VARCHAR (10)   NULL,
    [Marital_Status]   VARCHAR (20)   NULL,
    [UUID]             VARCHAR (10)   NOT NULL,
    [UserType]         VARCHAR (20)   NULL,
    [Remarks]          VARCHAR (200)  NULL,
    CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [uniqueUserName] UNIQUE NONCLUSTERED ([UserName] ASC),
    CONSTRAINT [UUID_Unique] UNIQUE NONCLUSTERED ([UUID] ASC)
);

