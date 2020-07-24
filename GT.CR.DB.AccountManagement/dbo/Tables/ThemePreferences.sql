CREATE TABLE [dbo].[ThemePreferences] (
    [ThemeID]   BIGINT         IDENTITY (1, 1) NOT NULL,
    [ThemeName] NVARCHAR (50)  NOT NULL,
    [ThemePath] NVARCHAR (200) NOT NULL,
    CONSTRAINT [PK_ThemePreferences] PRIMARY KEY CLUSTERED ([ThemeID] ASC)
);

