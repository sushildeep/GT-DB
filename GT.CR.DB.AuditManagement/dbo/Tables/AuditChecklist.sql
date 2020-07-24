﻿CREATE TABLE [dbo].[AuditChecklist] (
    [AuditChecklistID]                INT            IDENTITY (1, 1) NOT NULL,
    [ChecklistName]                   NVARCHAR (MAX) NULL,
    [ChecklistMasterCode]             NVARCHAR (MAX) NULL,
    [ChecklistCode]                   NVARCHAR (MAX) NULL,
    [ChecklistIcon]                   NVARCHAR (MAX) NULL,
    [ChecklistCategory]               NVARCHAR (MAX) NULL,
    [ChecklistType]                   NVARCHAR (MAX) NULL,
    [ChecklistDescription]            NVARCHAR (MAX) NULL,
    [ChecklistScheduledStartDateTime] DATETIME2 (7)  NOT NULL,
    [ChecklistScheduledEndDateTime]   DATETIME2 (7)  NOT NULL,
    [ChecklistStartDateTime]          DATETIME2 (7)  NOT NULL,
    [ChecklistEndDateTime]            DATETIME2 (7)  NOT NULL,
    [ChecklistObservation]            NVARCHAR (MAX) NULL,
    [LastCheckPerformed]              INT            NOT NULL,
    [ChecklistDepartment]             NVARCHAR (MAX) NULL,
    [ChecklistArea]                   NVARCHAR (MAX) NULL,
    [ChecklistSubArea]                NVARCHAR (MAX) NULL,
    [PerformedBy]                     NVARCHAR (MAX) NULL,
    [PerformedRole]                   NVARCHAR (MAX) NULL,
    [ChecklistStatus]                 NVARCHAR (MAX) NULL,
    [TotalNoOfChecks]                 INT            NOT NULL,
    [TotalYesResponse]                INT            NOT NULL,
    [TotalNoResponse]                 INT            NOT NULL,
    [TotalScore]                      FLOAT (53)     NOT NULL,
    [MaxScore]                        FLOAT (53)     NOT NULL,
    [ChecklistCompliancePercentage]   FLOAT (53)     NOT NULL,
    [Submitted]                       BIT            NOT NULL,
    [SubmittedDateTime]               DATETIME2 (7)  NOT NULL,
    [Synced]                          BIT            NOT NULL,
    [SyncedDateTime]                  DATETIME2 (7)  NOT NULL,
    [Locked]                          BIT            NOT NULL,
    [Pinned]                          BIT            NOT NULL,
    [AuditID]                         INT            NULL,
    [UserChecklistAuditInfoID]        INT            NULL,
    [ChecklistSubAreaCode]            NVARCHAR (MAX) NULL,
    [LastModifiedBy]                  NVARCHAR (MAX) NULL,
    [LastModifiedDateTime]            DATETIME2 (7)  NULL,
    [CreatedBy]                       NVARCHAR (MAX) NULL,
    [CreatedDateTime]                 DATETIME2 (7)  NULL,
    CONSTRAINT [PK_AuditChecklist] PRIMARY KEY CLUSTERED ([AuditChecklistID] ASC),
    CONSTRAINT [FK_AuditChecklist_Audit_AuditID] FOREIGN KEY ([AuditID]) REFERENCES [dbo].[Audit] ([AuditID]),
    CONSTRAINT [FK_AuditChecklist_UserChecklistAuditInfos_UserChecklistAuditInfoID] FOREIGN KEY ([UserChecklistAuditInfoID]) REFERENCES [dbo].[UserChecklistAuditInfos] ([UserChecklistAuditInfoID])
);
