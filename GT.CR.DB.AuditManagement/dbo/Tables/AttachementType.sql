CREATE TABLE [dbo].[AttachementType] (
    [AttachementTypeID]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]                NVARCHAR (MAX) NULL,
    [AttachementTypeCode] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_AttachementType] PRIMARY KEY CLUSTERED ([AttachementTypeID] ASC)
);

