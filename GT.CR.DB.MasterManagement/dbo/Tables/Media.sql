CREATE TABLE [dbo].[Media] (
    [MediaID]     INT            IDENTITY (1, 1) NOT NULL,
    [Format]      NVARCHAR (MAX) NULL,
    [Name]        NVARCHAR (MAX) NULL,
    [Size]        NVARCHAR (MAX) NULL,
    [URL]         NVARCHAR (MAX) NULL,
    [CheckID]     INT            NULL,
    [ChecklistID] INT            NULL,
    CONSTRAINT [PK_Media] PRIMARY KEY CLUSTERED ([MediaID] ASC),
    CONSTRAINT [FK_Media_Check_CheckID] FOREIGN KEY ([CheckID]) REFERENCES [dbo].[Check] ([CheckID]),
    CONSTRAINT [FK_Media_Checklist_ChecklistID] FOREIGN KEY ([ChecklistID]) REFERENCES [dbo].[Checklist] ([ChecklistID])
);

