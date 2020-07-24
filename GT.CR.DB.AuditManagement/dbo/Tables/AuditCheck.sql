CREATE TABLE [dbo].[AuditCheck] (
    [AuditCheckID]         INT            IDENTITY (1, 1) NOT NULL,
    [CheckCode]            NVARCHAR (MAX) NULL,
    [CheckName]            NVARCHAR (MAX) NULL,
    [CheckImage]           NVARCHAR (MAX) NULL,
    [CheckResponse]        NVARCHAR (MAX) NULL,
    [CheckAnswer]          NVARCHAR (MAX) NULL,
    [PerformedBy]          NVARCHAR (MAX) NULL,
    [PerformedDateTime]    DATETIME2 (7)  NOT NULL,
    [Remark]               NVARCHAR (MAX) NULL,
    [CheckScore]           FLOAT (53)     NOT NULL,
    [CheckType]            NVARCHAR (MAX) NULL,
    [CheckCategory]        NVARCHAR (MAX) NULL,
    [CheckStatus]          NVARCHAR (MAX) NULL,
    [AuditChecklistID]     INT            NULL,
    [CheckDescription]     NVARCHAR (MAX) NULL,
    [LastModifiedBy]       NVARCHAR (MAX) NULL,
    [LastModifiedDateTime] DATETIME2 (7)  NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDateTime]      DATETIME2 (7)  NULL,
    CONSTRAINT [PK_AuditCheck] PRIMARY KEY CLUSTERED ([AuditCheckID] ASC),
    CONSTRAINT [FK_AuditCheck_AuditChecklist_AuditChecklistID] FOREIGN KEY ([AuditChecklistID]) REFERENCES [dbo].[AuditChecklist] ([AuditChecklistID])
);

