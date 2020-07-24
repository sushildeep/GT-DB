CREATE TABLE [dbo].[UserSession] (
    [UserName]  NVARCHAR (50) NOT NULL,
    [SessionID] NVARCHAR (50) NOT NULL,
    [AppName]   NVARCHAR (50) NULL,
    [TimeStamp] DATETIME      NOT NULL
);

