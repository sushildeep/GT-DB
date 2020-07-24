CREATE TABLE [dbo].[NotificationCategory] (
    [NotificationCategoryID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                     NVARCHAR (MAX) NULL,
    [NotificationCategoryCode] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_NotificationCategory] PRIMARY KEY CLUSTERED ([NotificationCategoryID] ASC)
);

