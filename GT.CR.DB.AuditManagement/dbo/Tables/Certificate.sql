CREATE TABLE [dbo].[Certificate] (
    [CertificateID]          INT            IDENTITY (1, 1) NOT NULL,
    [CertificateName]        NVARCHAR (MAX) NULL,
    [CertificateDescription] NVARCHAR (MAX) NULL,
    [IssuedDateTime]         DATETIME2 (7)  NOT NULL,
    [ValidityDateTime]       DATETIME2 (7)  NOT NULL,
    [AuthorizedBy]           NVARCHAR (MAX) NULL,
    [IssuerLogo]             NVARCHAR (MAX) NULL,
    [IssuerName]             NVARCHAR (MAX) NULL,
    [CertificateTypeID]      INT            NOT NULL,
    CONSTRAINT [PK_Certificate] PRIMARY KEY CLUSTERED ([CertificateID] ASC),
    CONSTRAINT [FK_Certificate_CertificateType_CertificateTypeID] FOREIGN KEY ([CertificateTypeID]) REFERENCES [dbo].[CertificateType] ([CertificateTypeID]) ON DELETE CASCADE
);

