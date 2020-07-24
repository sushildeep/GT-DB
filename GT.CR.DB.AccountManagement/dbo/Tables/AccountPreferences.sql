CREATE TABLE [dbo].[AccountPreferences] (
    [AccountCode]         VARCHAR (10) NOT NULL,
    [ModuleCode]          VARCHAR (10) NOT NULL,
    [AccountPreferenceID] BIGINT       IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([AccountPreferenceID] ASC),
    CONSTRAINT [AccountPreferences_Account_fk] FOREIGN KEY ([AccountCode]) REFERENCES [dbo].[AccountInfoes] ([AccountCode]),
    CONSTRAINT [AccountPreferences_ModuleCode_fk] FOREIGN KEY ([ModuleCode]) REFERENCES [dbo].[BusinessModules] ([BusinessModuleCode])
);


GO
ALTER TABLE [dbo].[AccountPreferences] NOCHECK CONSTRAINT [AccountPreferences_Account_fk];


GO
ALTER TABLE [dbo].[AccountPreferences] NOCHECK CONSTRAINT [AccountPreferences_ModuleCode_fk];

