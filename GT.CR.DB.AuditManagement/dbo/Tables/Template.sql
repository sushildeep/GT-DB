CREATE TABLE [dbo].[Template] (
    [TemplateID]             INT            IDENTITY (1, 1) NOT NULL,
    [TemplateName]           NVARCHAR (MAX) NULL,
    [TemplateDescription]    NVARCHAR (MAX) NULL,
    [TemplateMessage]        NVARCHAR (MAX) NULL,
    [NotificationCategoryID] INT            NULL,
    [ReminderCategoryID]     INT            NULL,
    CONSTRAINT [PK_Template] PRIMARY KEY CLUSTERED ([TemplateID] ASC),
    CONSTRAINT [FK_Template_NotificationCategory_NotificationCategoryID] FOREIGN KEY ([NotificationCategoryID]) REFERENCES [dbo].[NotificationCategory] ([NotificationCategoryID]),
    CONSTRAINT [FK_Template_ReminderCategory_ReminderCategoryID] FOREIGN KEY ([ReminderCategoryID]) REFERENCES [dbo].[ReminderCategory] ([ReminderCategoryID])
);

