﻿-- =============================================
-- Author:		Keshav
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[LastDeatils] 
	-- Add the parameters for the stored procedure here
		@DT As [dbo].[LastPerformed] Readonly 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select * from (
	select a.AuditName,[AuditChecklistID] id,acl.[ChecklistMasterCode][ChecklistCode],acl.[TotalNoOfChecks],[TotalYesResponse],
	[TotalNoResponse],[PerformedRole],[PerformedBy],[ChecklistEndDateTime],acl.ChecklistScheduledStartDateTime,acl.ChecklistSubArea,acl.[ChecklistArea]
 ,row_number() over (partition by acl.[ChecklistCode]   order by [ChecklistEndDateTime] desc) rn 
 from  [dbo].[UserChecklistAuditInfos] u
join [dbo].[Audit] a on u.UserChecklistAuditInfoID = a.UserChecklistAuditInfoID
join [dbo].[AuditChecklist]acl on a.AuditID = acl.AuditID AND [ChecklistEndDateTime] != '0001-01-01 00:00:00.0000000'
join @DT dt on dt.Location = u.LocationName and a.AuditStatus = 'CLOSED')a where rn=1
end

/*
declare @dt [dbo].[LastPerformed]  insert into @dt select '','Big India Mall',''
exec [LastDeatils] @dt
*/