CREATE TABLE [dbo].[UserReminder] (
    [UserReminderID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]         NVARCHAR (MAX) NULL,
    [ReminderID]     INT            NULL,
    CONSTRAINT [PK_UserReminder] PRIMARY KEY CLUSTERED ([UserReminderID] ASC),
    CONSTRAINT [FK_UserReminder_Reminder_ReminderID] FOREIGN KEY ([ReminderID]) REFERENCES [dbo].[Reminder] ([ReminderID])
);

