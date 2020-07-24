-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[deletemastertables] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from  [dbo].[Check]
delete from [dbo].[Checklist]
delete from [dbo].[ChecklistArea]

dbcc checkident('Check', reseed, 1)
dbcc checkident('Checklist', reseed, 1)
dbcc checkident('ChecklistArea', reseed, 1) 

END

