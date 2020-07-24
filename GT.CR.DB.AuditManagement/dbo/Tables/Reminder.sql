CREATE TABLE [dbo].[Reminder] (
    [ReminderID]                 INT            IDENTITY (1, 1) NOT NULL,
    [ReminderDescription]        NVARCHAR (MAX) NULL,
    [ReminderDateTime]           DATETIME2 (7)  NOT NULL,
    [ReminderSnooze]             INT            NOT NULL,
    [ReminderSent]               BIT            NOT NULL,
    [NotificationReminderTypeID] INT            NOT NULL,
    [ReminderCategoryID]         INT            NOT NULL,
    [AuditID]                    INT            NULL,
    [AuditChecklistID]           INT            NULL,
    CONSTRAINT [PK_Reminder] PRIMARY KEY CLUSTERED ([ReminderID] ASC),
    CONSTRAINT [FK_Reminder_Audit_AuditID] FOREIGN KEY ([AuditID]) REFERENCES [dbo].[Audit] ([AuditID]),
    CONSTRAINT [FK_Reminder_AuditChecklist_AuditChecklistID] FOREIGN KEY ([AuditChecklistID]) REFERENCES [dbo].[AuditChecklist] ([AuditChecklistID]),
    CONSTRAINT [FK_Reminder_NotificationReminderType_NotificationReminderTypeID] FOREIGN KEY ([NotificationReminderTypeID]) REFERENCES [dbo].[NotificationReminderType] ([NotificationReminderTypeID]) ON DELETE CASCADE,
    CONSTRAINT [FK_Reminder_ReminderCategory_ReminderCategoryID] FOREIGN KEY ([ReminderCategoryID]) REFERENCES [dbo].[ReminderCategory] ([ReminderCategoryID]) ON DELETE CASCADE
);

