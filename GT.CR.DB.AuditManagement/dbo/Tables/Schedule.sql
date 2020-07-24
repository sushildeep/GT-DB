CREATE TABLE [dbo].[Schedule] (
    [ScheduleID]     INT            IDENTITY (1, 1) NOT NULL,
    [AssignedTo]     NVARCHAR (MAX) NULL,
    [AssignedBy]     NVARCHAR (MAX) NULL,
    [StartDateTime]  DATETIME2 (7)  NOT NULL,
    [EndDateTime]    DATETIME2 (7)  NOT NULL,
    [ScheduleStatus] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED ([ScheduleID] ASC)
);

