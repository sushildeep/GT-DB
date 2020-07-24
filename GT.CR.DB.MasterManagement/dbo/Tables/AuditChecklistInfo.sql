CREATE TABLE [dbo].[AuditChecklistInfo] (
    [AuditChecklistInfoID]            INT            IDENTITY (1, 1) NOT NULL,
    [ChecklistScheduledStartDateTime] DATETIME2 (7)  NOT NULL,
    [ChecklistScheduledEndDateTime]   DATETIME2 (7)  NOT NULL,
    [AreaName]                        NVARCHAR (MAX) NULL,
    [SubAreaName]                     NVARCHAR (MAX) NULL,
    [SubAreaCode]                     NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_AuditChecklistInfo] PRIMARY KEY CLUSTERED ([AuditChecklistInfoID] ASC)
);

