CREATE TABLE [dbo].[UserChecklistAuditInfos_bak_bs] (
    [UserChecklistAuditInfoID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]                   NVARCHAR (450) NOT NULL,
    [FBO]                      NVARCHAR (450) NOT NULL,
    [LocationName]             NVARCHAR (450) NOT NULL,
    [City]                     NVARCHAR (450) NOT NULL,
    [Status]                   NVARCHAR (MAX) NULL,
    [CreatedBy]                NVARCHAR (MAX) NULL,
    [CreatedDateTime]          DATETIME2 (7)  NOT NULL,
    [LocationCode]             NVARCHAR (MAX) NULL,
    [LastModifiedBy]           NVARCHAR (MAX) NULL,
    [LastModifiedDateTime]     DATETIME2 (7)  NULL,
    [FBOCode]                  NVARCHAR (MAX) NULL
);

