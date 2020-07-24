CREATE TABLE [dbo].[ScheduleHistory] (
    [ScheduleHistoryID] INT            IDENTITY (1, 1) NOT NULL,
    [AssignedTo]        NVARCHAR (MAX) NULL,
    [AssignedBy]        NVARCHAR (MAX) NULL,
    [StartDateTime]     DATETIME2 (7)  NOT NULL,
    [EndDateTime]       DATETIME2 (7)  NOT NULL,
    [ScheduleStatus]    NVARCHAR (MAX) NULL,
    [ModifiedBy]        NVARCHAR (MAX) NULL,
    [ModifiedDateTime]  DATETIME2 (7)  NOT NULL,
    [ScheduleID]        INT            NULL,
    CONSTRAINT [PK_ScheduleHistory] PRIMARY KEY CLUSTERED ([ScheduleHistoryID] ASC),
    CONSTRAINT [FK_ScheduleHistory_Schedule_ScheduleID] FOREIGN KEY ([ScheduleID]) REFERENCES [dbo].[Schedule] ([ScheduleID])
);

