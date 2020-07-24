CREATE TABLE [dbo].[AuditInfo] (
    [AuditInfoID]                 INT            IDENTITY (1, 1) NOT NULL,
    [AuditName]                   NVARCHAR (MAX) NULL,
    [AuditImage]                  NVARCHAR (MAX) NULL,
    [AuditCode]                   NVARCHAR (MAX) NULL,
    [AssignedToUserName]          NVARCHAR (MAX) NULL,
    [AssignedToUserUUID]          NVARCHAR (MAX) NULL,
    [AuditLocation]               NVARCHAR (MAX) NULL,
    [AuditFBO]                    NVARCHAR (MAX) NULL,
    [AuditScheduledStartDateTime] DATETIME2 (7)  NOT NULL,
    [AuditScheduledEndDateTime]   DATETIME2 (7)  NOT NULL,
    [AuditExpiryDateTime]         DATETIME2 (7)  NOT NULL,
    [AuditType]                   NVARCHAR (MAX) NULL,
    [AuditCity]                   NVARCHAR (MAX) NULL,
    [AuditCategory]               NVARCHAR (MAX) NULL,
    [AuditStatus]                 NVARCHAR (MAX) NULL,
    [CreatedBy]                   NVARCHAR (MAX) NULL,
    [CreatedDateTime]             DATETIME2 (7)  NOT NULL,
    [AuditLocationCode]           NVARCHAR (MAX) NULL,
    [FBOCode]                     NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_AuditInfo] PRIMARY KEY CLUSTERED ([AuditInfoID] ASC)
);

