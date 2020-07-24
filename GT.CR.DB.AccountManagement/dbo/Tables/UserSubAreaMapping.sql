CREATE TABLE [dbo].[UserSubAreaMapping] (
    [UserSubAreaID]    BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserID]           BIGINT         NOT NULL,
    [SubAreaInfoID]    BIGINT         NOT NULL,
    [Status]           VARCHAR (15)   NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [LastModifiedBy]   NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([UserSubAreaID] ASC),
    FOREIGN KEY ([SubAreaInfoID]) REFERENCES [dbo].[SubAreaInfo] ([SubAreaInfoID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

