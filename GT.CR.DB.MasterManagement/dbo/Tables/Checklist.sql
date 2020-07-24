CREATE TABLE [dbo].[Checklist] (
    [ChecklistID]          INT            IDENTITY (1, 1) NOT NULL,
    [ChecklistCode]        NVARCHAR (MAX) NULL,
    [ChecklistName]        NVARCHAR (MAX) NULL,
    [ChecklistIcon]        NVARCHAR (MAX) NULL,
    [ChecklistDescription] NVARCHAR (MAX) NULL,
    [TotalNoOfChecks]      FLOAT (53)     NOT NULL,
    [MaxScore]             FLOAT (53)     NOT NULL,
    [Status]               NVARCHAR (MAX) NULL,
    [ChecklistCategory]    NVARCHAR (MAX) NULL,
    [ChecklistType]        NVARCHAR (MAX) NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDateTime]      DATETIME2 (7)  NOT NULL,
    [LastModifiedBy]       NVARCHAR (MAX) NULL,
    [LastModifiedDateTime] DATETIME2 (7)  NULL,
    CONSTRAINT [PK_Checklist] PRIMARY KEY CLUSTERED ([ChecklistID] ASC)
);




GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[UpdateCheckListCode]  
   ON  [dbo].[Checklist]
   AFTER  INSERT 
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
update c set CheckListCode = 'CL'+REPLICATE('0',7-len(c.CheckListID))+ convert(varchar(10),c.CheckListID)
from [CheckList] c join inserted i on c.CheckListID =i.CheckListID 
    -- Insert statements for trigger here

END