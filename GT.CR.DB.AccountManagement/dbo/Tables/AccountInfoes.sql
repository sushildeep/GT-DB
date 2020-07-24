CREATE TABLE [dbo].[AccountInfoes] (
    [AccountInfoID]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [AccountName]         NVARCHAR (MAX) NULL,
    [Logo]                NVARCHAR (MAX) NULL,
    [Email]               NVARCHAR (MAX) NULL,
    [DomainName]          NVARCHAR (MAX) NULL,
    [ParentAccountID]     BIGINT         NULL,
    [CreatedBy]           NVARCHAR (MAX) NULL,
    [CreatedDate]         DATETIME       NULL,
    [UpdatedBy]           NVARCHAR (MAX) NULL,
    [LastModifiedDate]    DATETIME       NULL,
    [LogoPath]            NVARCHAR (MAX) NULL,
    [AccountCode]         VARCHAR (10)   NOT NULL,
    [PhoneNumber]         NVARCHAR (MAX) NULL,
    [Category]            NVARCHAR (MAX) NULL,
    [AccountAbbreviation] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_dbo.AccountInfoes] PRIMARY KEY CLUSTERED ([AccountInfoID] ASC),
    CONSTRAINT [FK_dbo.AccountInfoes_dbo.AccountInfoes_ParentAccountID] FOREIGN KEY ([ParentAccountID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID]),
    CONSTRAINT [AccountCode_Unique] UNIQUE NONCLUSTERED ([AccountCode] ASC)
);


GO
ALTER TABLE [dbo].[AccountInfoes] NOCHECK CONSTRAINT [FK_dbo.AccountInfoes_dbo.AccountInfoes_ParentAccountID];

