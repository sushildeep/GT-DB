-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE procedure [dbo].[GetCheckInfo] 
	-- Add the parameters for the stored procedure here
 
@ChecklistCode [dbo].[List] readonly  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select *
	
	from [dbo].[AuditChecklist] acl
	join [dbo].[AuditCheck]ac on ac.[AuditChecklistID] = acl.[AuditChecklistID]
	join [dbo].[Attachement]a on  a.[AuditCheckID] = ac.[AuditCheckID]
	join @ChecklistCode cl on cl.[input] =acl.[ChecklistCode] 
END