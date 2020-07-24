CREATE TABLE [dbo].[NotificationReminderType] (
    [NotificationReminderTypeID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                         NVARCHAR (MAX) NULL,
    [NotificationReminderTypeCode] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_NotificationReminderType] PRIMARY KEY CLUSTERED ([NotificationReminderTypeID] ASC)
);

