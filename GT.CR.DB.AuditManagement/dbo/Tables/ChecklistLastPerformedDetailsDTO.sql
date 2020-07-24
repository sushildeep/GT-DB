CREATE TABLE [dbo].[ChecklistLastPerformedDetailsDTO] (
    [ID]                   INT            IDENTITY (1, 1) NOT NULL,
    [TotalNoOfChecks]      INT            NOT NULL,
    [TotalYesResponse]     INT            NOT NULL,
    [TotalNoResponse]      INT            NOT NULL,
    [ChecklistCode]        NVARCHAR (MAX) NULL,
    [PerformedBy]          NVARCHAR (MAX) NULL,
    [PerformedRole]        NVARCHAR (MAX) NULL,
    [ChecklistEndDateTime] DATETIME2 (7)  NOT NULL,
    CONSTRAINT [PK_ChecklistLastPerformedDetailsDTO] PRIMARY KEY CLUSTERED ([ID] ASC)
);

