CREATE TYPE [dbo].[LastModified] AS TABLE (
    [ParentCode]           VARCHAR (100) NULL,
    [Code]                 VARCHAR (100) NULL,
    [CodeStatus]           VARCHAR (100) NULL,
    [LastModifiedDateTime] DATETIME2 (7) NULL);

