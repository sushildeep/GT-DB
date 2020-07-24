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
	delete from [dbo].AreaChecks
	delete from  [dbo].[Check]
delete from [dbo].[Checklist]
delete from [dbo].[AuditInfo]
delete from [dbo].[AuditChecklistInfo]
delete from [dbo].[AuditCheck]


dbcc checkident('Check', reseed, 0)
dbcc checkident('Checklist', reseed, 0)
dbcc checkident('AreaChecks', reseed, 0) 
dbcc checkident('AuditInfo', reseed, 0) 
dbcc checkident('AuditChecklistInfo', reseed, 0) 
dbcc checkident('AuditCheck', reseed, 0) 

END