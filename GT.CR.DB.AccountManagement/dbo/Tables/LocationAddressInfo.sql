CREATE TABLE [dbo].[LocationAddressInfo] (
    [LocationAddressInfoID] BIGINT            IDENTITY (1, 1) NOT NULL,
    [OfficeLocationID]      BIGINT            NOT NULL,
    [AddressLine1]          NVARCHAR (MAX)    NULL,
    [AddressLine2]          NVARCHAR (MAX)    NULL,
    [City]                  VARCHAR (100)     NULL,
    [ZipCode]               VARCHAR (20)      NULL,
    [County]                VARCHAR (100)     NULL,
    [State]                 VARCHAR (100)     NULL,
    [Country]               VARCHAR (100)     NULL,
    [IsPrimary]             BIT               NULL,
    [Status]                VARCHAR (15)      NULL,
    [CreatedBy]             NVARCHAR (MAX)    NULL,
    [CreatedDate]           DATETIME          NULL,
    [LastModifiedBy]        NVARCHAR (MAX)    NULL,
    [LastModifiedDate]      DATETIME          NULL,
    [Longitude]             [sys].[geography] NULL,
    [Latitude]              [sys].[geography] NULL,
    PRIMARY KEY CLUSTERED ([LocationAddressInfoID] ASC),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID])
);

