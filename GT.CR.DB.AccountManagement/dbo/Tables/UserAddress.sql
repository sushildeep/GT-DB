CREATE TABLE [dbo].[UserAddress] (
    [UserAddressID]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [AddressLine1]     NVARCHAR (MAX) NULL,
    [AddressLine2]     NVARCHAR (MAX) NULL,
    [street]           NVARCHAR (200) NULL,
    [City]             NVARCHAR (MAX) NULL,
    [County]           NVARCHAR (MAX) NULL,
    [State]            NVARCHAR (MAX) NULL,
    [Country]          NVARCHAR (MAX) NULL,
    [ZipCode]          NVARCHAR (MAX) NULL,
    [UserID]           BIGINT         NOT NULL,
    [AddressType]      NVARCHAR (50)  NOT NULL,
    [IsPrimary]        BIT            NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [UpdatedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    CONSTRAINT [PK_dbo.UserAddress] PRIMARY KEY CLUSTERED ([UserAddressID] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

