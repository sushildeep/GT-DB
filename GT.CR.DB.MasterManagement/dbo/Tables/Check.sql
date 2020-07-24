CREATE TABLE [dbo].[Check] (
    [CheckID]              INT            IDENTITY (1, 1) NOT NULL,
    [CheckCode]            NVARCHAR (MAX) NULL,
    [CheckTitle]           NVARCHAR (MAX) NULL,
    [CheckDescription]     NVARCHAR (MAX) NULL,
    [CheckAnswer]          NVARCHAR (MAX) NULL,
    [CheckImage]           NVARCHAR (MAX) NULL,
    [Score]                FLOAT (53)     NULL,
    [Status]               NVARCHAR (MAX) NULL,
    [CreatedBy]            NVARCHAR (MAX) NULL,
    [CreatedDateTime]      DATETIME2 (7)  NOT NULL,
    [CheckType]            NVARCHAR (MAX) NULL,
    [LastModifiedBy]       NVARCHAR (MAX) NULL,
    [LastModifiedDateTime] DATETIME2 (7)  NULL,
    CONSTRAINT [PK_Check] PRIMARY KEY CLUSTERED ([CheckID] ASC)
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create TRIGGER [dbo].[UpdateCheckCode]  
   ON  [dbo].[Check]
   AFTER  INSERT 
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
update c set CheckCode = 'CH'+REPLICATE('0',7-len(c.CheckID))+ convert(varchar(10),c.CheckID)
from [Check] c join inserted i on c.CheckID =i.CheckID 
    -- Insert statements for trigger here

END