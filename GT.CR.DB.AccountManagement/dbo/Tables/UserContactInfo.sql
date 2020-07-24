CREATE TABLE [dbo].[UserContactInfo] (
    [UserContactInfo]  INT            IDENTITY (1, 1) NOT NULL,
    [ContactType]      NVARCHAR (50)  NOT NULL,
    [ContactValue]     NVARCHAR (200) NOT NULL,
    [IsPrimary]        BIT            NULL,
    [UserID]           BIGINT         NOT NULL,
    [CreatedBy]        NVARCHAR (MAX) NULL,
    [CreatedDate]      DATETIME       NULL,
    [UpdatedBy]        NVARCHAR (MAX) NULL,
    [LastModifiedDate] DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([UserContactInfo] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]),
    CONSTRAINT [UserContact_Unique] UNIQUE NONCLUSTERED ([ContactType] ASC, [ContactValue] ASC, [UserID] ASC)
);

