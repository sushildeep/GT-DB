CREATE TABLE [dbo].[UserPreferences] (
    [UserPreferenceID]    BIGINT        IDENTITY (1, 1) NOT NULL,
    [UserID]              BIGINT        NOT NULL,
    [AccountPreferenceID] BIGINT        NOT NULL,
    [TimeZoneId]          VARCHAR (100) NULL,
    [FontId]              BIGINT        NULL,
    [ThemeID]             BIGINT        NULL,
    [DeployemntTagName]   VARCHAR (200) NULL,
    [OfficeLocationID]    BIGINT        NULL,
    [RoleID]              BIGINT        NULL,
    CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED ([UserPreferenceID] ASC),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID]),
    FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID])
);

