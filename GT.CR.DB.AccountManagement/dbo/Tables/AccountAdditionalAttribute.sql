CREATE TABLE [dbo].[AccountAdditionalAttribute] (
    [AccountInfoID]         BIGINT         NOT NULL,
    [AccountAttributeName]  NVARCHAR (MAX) NULL,
    [AccountAttributeValue] NVARCHAR (MAX) NULL,
    [Status]                VARCHAR (15)   NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [LastModifiedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    [AccountAttributeID]    INT            IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([AccountAttributeID] ASC),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID])
);

