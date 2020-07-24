CREATE TABLE [dbo].[Departments] (
    [DepartmentID]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [DepartmentCode]       VARCHAR (10)   NOT NULL,
    [Email]                NVARCHAR (MAX) NULL,
    [Name]                 VARCHAR (200)  NOT NULL,
    [BusinessModuleInfoID] BIGINT         NOT NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDate]          DATETIME       NULL,
    [UpdatedBy]            NVARCHAR (MAX) NULL,
    [LastModifiedDate]     DATETIME       NULL,
    [AccountInfoID]        BIGINT         NULL,
    [Abbreviation]         VARCHAR (30)   NULL,
    CONSTRAINT [PK_dbo.Departments] PRIMARY KEY CLUSTERED ([DepartmentID] ASC),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID]),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID]),
    CONSTRAINT [FK_dbo.Departments_dbo.BusinessModuleInfoes_BusinessModuleInfoID] FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]) ON DELETE CASCADE,
    CONSTRAINT [dept_Unique] UNIQUE NONCLUSTERED ([DepartmentCode] ASC)
);

