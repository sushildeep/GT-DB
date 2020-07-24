CREATE TABLE [dbo].[BusinessProcessInfoes] (
    [BusinessProcessInfoID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [SubscribedDate]        DATETIME       NOT NULL,
    [AccountID]             BIGINT         NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [UpdatedBy]             NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    [BusinessProcessCode]   VARCHAR (10)   NULL,
    CONSTRAINT [PK_dbo.BusinessProcessInfoes] PRIMARY KEY CLUSTERED ([BusinessProcessInfoID] ASC),
    CONSTRAINT [BusinessProcessCode_fk] FOREIGN KEY ([BusinessProcessCode]) REFERENCES [dbo].[BusinessProcesses] ([BusinessProcessCode]),
    CONSTRAINT [FK_dbo.BusinessProcessInfoes_dbo.AccountInfoes_AccountID] FOREIGN KEY ([AccountID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID])
);

