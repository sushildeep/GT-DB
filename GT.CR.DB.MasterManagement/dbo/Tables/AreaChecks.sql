CREATE TABLE [dbo].[AreaChecks] (
    [AreaChecksID] INT            IDENTITY (1, 1) NOT NULL,
    [SubAreaCode]  NVARCHAR (450) NOT NULL,
    [CheckID]      INT            NOT NULL,
    [ChecklistID]  INT            NOT NULL,
    CONSTRAINT [PK_AreaChecks] PRIMARY KEY CLUSTERED ([AreaChecksID] ASC),
    CONSTRAINT [FK_AreaChecks_Check_CheckID] FOREIGN KEY ([CheckID]) REFERENCES [dbo].[Check] ([CheckID]) ON DELETE CASCADE,
    CONSTRAINT [FK_AreaChecks_Checklist_ChecklistID] FOREIGN KEY ([ChecklistID]) REFERENCES [dbo].[Checklist] ([ChecklistID]) ON DELETE CASCADE
);

