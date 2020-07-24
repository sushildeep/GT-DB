CREATE TABLE [dbo].[CertificateType] (
    [CertificateTypeID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                NVARCHAR (MAX) NULL,
    [CertificateTypeCode] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_CertificateType] PRIMARY KEY CLUSTERED ([CertificateTypeID] ASC)
);

