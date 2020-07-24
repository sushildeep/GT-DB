CREATE TABLE [dbo].[UserTeams] (
    [UserTeamID]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [AccountCode]           VARCHAR (10)   NOT NULL,
    [BusinessProcessInfoID] BIGINT         NOT NULL,
    [BusinessModuleInfoID]  BIGINT         NOT NULL,
    [DepartmentCode]        VARCHAR (10)   NOT NULL,
    [TeamID]                BIGINT         NOT NULL,
    [UserID]                BIGINT         NOT NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [UpdatedBy]             NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    CONSTRAINT [PK_dbo.UserTeams] PRIMARY KEY CLUSTERED ([UserTeamID] ASC),
    CONSTRAINT [FK_dbo.UserTeams_dbo.Teams_TeamID] FOREIGN KEY ([TeamID]) REFERENCES [dbo].[Teams] ([TeamID]) ON DELETE CASCADE,
    CONSTRAINT [UserTeams_AccountCode_FK] FOREIGN KEY ([AccountCode]) REFERENCES [dbo].[AccountInfoes] ([AccountCode]),
    CONSTRAINT [UserTeams_BusinessModuleInfo_FK] FOREIGN KEY ([BusinessModuleInfoID]) REFERENCES [dbo].[BusinessModuleInfoes] ([BusinessModuleInfoID]),
    CONSTRAINT [UserTeams_BusinessProcessInfo_FK] FOREIGN KEY ([BusinessProcessInfoID]) REFERENCES [dbo].[BusinessProcessInfoes] ([BusinessProcessInfoID]),
    CONSTRAINT [UserTeams_DepartmentCode_FK] FOREIGN KEY ([DepartmentCode]) REFERENCES [dbo].[Departments] ([DepartmentCode]),
    CONSTRAINT [UserTeams_Userid_FK] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

