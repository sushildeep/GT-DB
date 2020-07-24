CREATE TABLE [dbo].[UserAdditionalAttributes] (
    [UserAttributeId] INT            IDENTITY (1, 1) NOT NULL,
    [AttributeName]   NVARCHAR (50)  NULL,
    [AttributeValue]  NVARCHAR (MAX) NULL,
    [UserId]          BIGINT         NOT NULL,
    CONSTRAINT [PK_UserAttributes] PRIMARY KEY CLUSTERED ([UserAttributeId] ASC),
    CONSTRAINT [FK_UserAttributes_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserID])
);

