CREATE TABLE [dbo].[AccountAddressInfo] (
    [AccountAddressInfoID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [AccountInfoID]        BIGINT         NOT NULL,
    [AddressLine1]         NVARCHAR (MAX) NULL,
    [AddressLine2]         NVARCHAR (MAX) NULL,
    [City]                 VARCHAR (100)  NULL,
    [ZipCode]              VARCHAR (20)   NULL,
    [County]               VARCHAR (100)  NULL,
    [State]                VARCHAR (100)  NULL,
    [Country]              VARCHAR (100)  NULL,
    [IsPrimary]            BIT            NULL,
    [Status]               VARCHAR (15)   NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDate]          DATETIME       NULL,
    [LastModifiedBy]       NVARCHAR (MAX) NULL,
    [LastModifiedDate]     DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([AccountAddressInfoID] ASC),
    FOREIGN KEY ([AccountInfoID]) REFERENCES [dbo].[AccountInfoes] ([AccountInfoID])
);

