-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE procedure [dbo].[Deletetablesdata] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Attachement
	delete from AuditCheck
	delete from AuditChecklist
	delete from audit
	delete from UserChecklistAuditInfos
	delete from NotificationLog
delete from [dbo].[P_MasterChecklist]


dbcc checkident('Audit', reseed, 0)
dbcc checkident('AuditCheck', reseed, 0)
dbcc checkident('AuditChecklist', reseed, 0)
dbcc checkident('Attachement', reseed, 0)
dbcc checkident('UserChecklistAuditInfos', reseed, 0)
END