CREATE TABLE [dbo].[AccountContactInfo] (
    [AccountContactInfoID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [AccountInfoID]        BIGINT         NOT NULL,
    [ContactType]          NVARCHAR (MAX) NULL,
    [ContactValue]         NVARCHAR (MAX) NULL,
    [IsPrimary]            BIT            NULL,
    [Status]               VARCHAR (15)   NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDate]          DATETIME       NULL,
    [LastModifiedBy]       NVARCHAR (MAX) NULL,
    [LastModifiedDate]     DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([AccountContactInfoID] ASC),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID])
);

