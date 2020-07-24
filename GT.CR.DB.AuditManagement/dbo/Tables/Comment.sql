CREATE TABLE [dbo].[Comment] (
    [CommentID]          INT            IDENTITY (1, 1) NOT NULL,
    [CommentDescription] NVARCHAR (MAX) NULL,
    [CommentedBy]        NVARCHAR (MAX) NULL,
    [CommentedDateTime]  DATETIME2 (7)  NOT NULL,
    [Pinned]             BIT            NOT NULL,
    [AuditChecklistID]   INT            NULL,
    [AuditCheckID]       INT            NULL,
    [AuditID]            INT            NULL,
    CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED ([CommentID] ASC),
    CONSTRAINT [FK_Comment_Audit_AuditID] FOREIGN KEY ([AuditID]) REFERENCES [dbo].[Audit] ([AuditID]),
    CONSTRAINT [FK_Comment_AuditCheck_AuditCheckID] FOREIGN KEY ([AuditCheckID]) REFERENCES [dbo].[AuditCheck] ([AuditCheckID]),
    CONSTRAINT [FK_Comment_AuditChecklist_AuditChecklistID] FOREIGN KEY ([AuditChecklistID]) REFERENCES [dbo].[AuditChecklist] ([AuditChecklistID])
);

