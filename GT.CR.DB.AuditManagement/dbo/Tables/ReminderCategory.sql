CREATE TABLE [dbo].[ReminderCategory] (
    [ReminderCategoryID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                 NVARCHAR (MAX) NULL,
    [ReminderCategoryCode] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_ReminderCategory] PRIMARY KEY CLUSTERED ([ReminderCategoryID] ASC)
);

