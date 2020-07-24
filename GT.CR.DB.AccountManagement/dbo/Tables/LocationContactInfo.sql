CREATE TABLE [dbo].[LocationContactInfo] (
    [LocationContactInfoID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [OfficeLocationID]      BIGINT         NOT NULL,
    [ContactType]           NVARCHAR (MAX) NULL,
    [ContactValue]          NVARCHAR (MAX) NULL,
    [IsPrimary]             BIT            NULL,
    [Status]                VARCHAR (15)   NULL,
    [CreatedBy]             NVARCHAR (MAX) NULL,
    [CreatedDate]           DATETIME       NULL,
    [LastModifiedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate]      DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([LocationContactInfoID] ASC),
    FOREIGN KEY ([OfficeLocationID]) REFERENCES [dbo].[OfficeLocation] ([OfficeLocationID])
);

