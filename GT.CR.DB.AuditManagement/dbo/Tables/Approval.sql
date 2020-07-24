CREATE TABLE [dbo].[Approval] (
    [ApprovalID]       INT            IDENTITY (1, 1) NOT NULL,
    [ApprovedBy]       NVARCHAR (MAX) NULL,
    [ApprovedDateTime] DATETIME2 (7)  NOT NULL,
    [Remarks]          NVARCHAR (MAX) NULL,
    [ApprovalStatus]   NVARCHAR (MAX) NULL,
    [UserID]           NVARCHAR (MAX) NULL,
    [AuditChecklistID] INT            NULL,
    CONSTRAINT [PK_Approval] PRIMARY KEY CLUSTERED ([ApprovalID] ASC),
    CONSTRAINT [FK_Approval_AuditChecklist_AuditChecklistID] FOREIGN KEY ([AuditChecklistID]) REFERENCES [dbo].[AuditChecklist] ([AuditChecklistID])
);

