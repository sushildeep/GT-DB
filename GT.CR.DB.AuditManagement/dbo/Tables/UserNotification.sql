CREATE TABLE [dbo].[UserNotification] (
    [UserNotificationID] INT            IDENTITY (1, 1) NOT NULL,
    [UserID]             NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_UserNotification] PRIMARY KEY CLUSTERED ([UserNotificationID] ASC)
);

