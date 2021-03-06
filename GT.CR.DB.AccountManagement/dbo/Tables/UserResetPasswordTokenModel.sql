﻿CREATE TABLE [dbo].[UserResetPasswordTokenModel] (
    [TOKEN]        VARCHAR (MAX)  NULL,
    [USERNAME]     NVARCHAR (100) NOT NULL,
    [CREATEDDATE]  DATETIME       NULL,
    [TOKENTYPE]    VARCHAR (MAX)  NULL,
    [STATUS]       VARCHAR (MAX)  NULL,
    [STATUSSTRING] VARCHAR (MAX)  NULL,
    PRIMARY KEY CLUSTERED ([USERNAME] ASC)
);

