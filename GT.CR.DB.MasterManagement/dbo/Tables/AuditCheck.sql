CREATE TABLE [dbo].[AuditCheck] (
    [AuditCheckID]         INT IDENTITY (1, 1) NOT NULL,
    [AuditInfoID]          INT NULL,
    [AuditChecklistInfoID] INT NULL,
    [AuditCheckInfoID]     INT NULL,
    [AreaChecksID]         INT NOT NULL,
    CONSTRAINT [PK_AuditCheck] PRIMARY KEY CLUSTERED ([AuditCheckID] ASC),
    CONSTRAINT [FK_AuditCheck_AreaChecks_AreaChecksID] FOREIGN KEY ([AreaChecksID]) REFERENCES [dbo].[AreaChecks] ([AreaChecksID]) ON DELETE CASCADE,
    CONSTRAINT [FK_AuditCheck_AuditCheckInfo_AuditCheckInfoID] FOREIGN KEY ([AuditCheckInfoID]) REFERENCES [dbo].[AuditCheckInfo] ([AuditCheckInfoID]),
    CONSTRAINT [FK_AuditCheck_AuditChecklistInfo_AuditChecklistInfoID] FOREIGN KEY ([AuditChecklistInfoID]) REFERENCES [dbo].[AuditChecklistInfo] ([AuditChecklistInfoID]),
    CONSTRAINT [FK_AuditCheck_AuditInfo_AuditInfoID] FOREIGN KEY ([AuditInfoID]) REFERENCES [dbo].[AuditInfo] ([AuditInfoID])
);

