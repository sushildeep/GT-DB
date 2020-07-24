CREATE TABLE [dbo].[UserChecklistAuditInfos] (
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
    [FBOCode]                  NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserChecklistAuditInfos] PRIMARY KEY CLUSTERED ([UserChecklistAuditInfoID] ASC),
    CONSTRAINT [AK_UserChecklistAuditInfos_UserID_FBO_LocationName_City] UNIQUE NONCLUSTERED ([UserID] ASC, [FBO] ASC, [LocationName] ASC, [City] ASC)
);

