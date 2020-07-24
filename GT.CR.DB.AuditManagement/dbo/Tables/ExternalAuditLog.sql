CREATE TABLE [dbo].[ExternalAuditLog] (
    [ExternalAuditLogID] INT            IDENTITY (1, 1) NOT NULL,
    [AuditDateTime]      DATETIME2 (7)  NOT NULL,
    [AuditedBy]          NVARCHAR (MAX) NULL,
    [AuditSource]        NVARCHAR (MAX) NULL,
    [LoggedBy]           NVARCHAR (MAX) NULL,
    [LogDateTime]        DATETIME2 (7)  NOT NULL,
    [AuditID]            INT            NULL,
    CONSTRAINT [PK_ExternalAuditLog] PRIMARY KEY CLUSTERED ([ExternalAuditLogID] ASC),
    CONSTRAINT [FK_ExternalAuditLog_Audit_AuditID] FOREIGN KEY ([AuditID]) REFERENCES [dbo].[Audit] ([AuditID])
);

