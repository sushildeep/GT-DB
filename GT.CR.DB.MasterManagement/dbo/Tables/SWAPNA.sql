CREATE TABLE [dbo].[SWAPNA] (
    [AuditName]                       NVARCHAR (255) NULL,
    [AuditImage]                      NVARCHAR (255) NULL,
    [AssignedToUserUUID]              NVARCHAR (255) NULL,
    [AuditLocation]                   NVARCHAR (255) NULL,
    [AuditFBO]                        NVARCHAR (255) NULL,
    [AuditScheduledStartDateTime]     DATETIME       NULL,
    [AuditScheduledEndDateTime]       DATETIME       NULL,
    [AuditExpiryDateTime]             DATETIME       NULL,
    [AuditCity]                       NVARCHAR (255) NULL,
    [AuditType]                       NVARCHAR (255) NULL,
    [AuditCategory]                   NVARCHAR (255) NULL,
    [ChecklistScheduledStartDateTime] DATETIME       NULL,
    [ChecklistScheduledEndDateTime]   DATETIME       NULL,
    [AreaName]                        NVARCHAR (255) NULL,
    [SubAreaName]                     NVARCHAR (255) NULL,
    [SubAreaCode]                     NVARCHAR (255) NULL,
    [ChecklistCode]                   NVARCHAR (255) NULL,
    [CheckCode]                       NVARCHAR (255) NULL,
    [AuditLocationCode]               NVARCHAR (255) NULL,
    [AssignedToUserName]              NVARCHAR (255) NULL
);

