CREATE TABLE [dbo].[NotificationLog] (
    [NotificationID]       NVARCHAR (450) NOT NULL,
    [FirebaseTopic]        NVARCHAR (MAX) NULL,
    [NotificationBody]     NVARCHAR (MAX) NULL,
    [NotificationDateTime] DATETIME2 (7)  NOT NULL,
    [NotificationStatus]   NVARCHAR (MAX) NULL,
    [AuditChecklistID]     INT            NULL,
    [AuditID]              INT            NULL,
    CONSTRAINT [PK_NotificationLog] PRIMARY KEY CLUSTERED ([NotificationID] ASC),
    CONSTRAINT [FK_NotificationLog_Audit_AuditID] FOREIGN KEY ([AuditID]) REFERENCES [dbo].[Audit] ([AuditID]),
    CONSTRAINT [FK_NotificationLog_AuditChecklist_AuditChecklistID] FOREIGN KEY ([AuditChecklistID]) REFERENCES [dbo].[AuditChecklist] ([AuditChecklistID])
);

