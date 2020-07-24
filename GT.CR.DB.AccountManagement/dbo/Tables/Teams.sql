CREATE TABLE [dbo].[Teams] (
    [TeamID]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [TeamCode]         VARCHAR (10)   NOT NULL,
    [Name]             VARCHAR (200)  NOT NULL,
    [Email]            NVARCHAR (MAX) NULL,
    [DepartmentID]     BIGINT         NOT NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [UpdatedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    CONSTRAINT [PK_dbo.Teams] PRIMARY KEY CLUSTERED ([TeamID] ASC),
    CONSTRAINT [FK_dbo.Teams_dbo.Departments_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]) ON DELETE CASCADE,
    CONSTRAINT [TeamCode_Unique] UNIQUE NONCLUSTERED ([TeamCode] ASC)
);

