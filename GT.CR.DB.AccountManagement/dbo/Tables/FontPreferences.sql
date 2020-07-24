CREATE TABLE [dbo].[FontPreferences] (
    [FontID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [Size]   INT           NOT NULL,
    [Value]  NVARCHAR (10) NULL,
    PRIMARY KEY CLUSTERED ([FontID] ASC)
);

