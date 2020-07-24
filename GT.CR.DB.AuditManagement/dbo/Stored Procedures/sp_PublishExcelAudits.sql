CREATE procedure [dbo].[sp_PublishExcelAudits]
as 
begin

declare  cur cursor for 
select AuditCode  from Master_AuditInfo m  where not exists (select * from [dbo].[Audit] t where t.AuditCode = m.AuditCode)
declare @auditCode varchar(20)
open cur
fetch next from cur into @auditCode

while(@@FETCH_STATUS=0)
begin
Exec PublishAudit @auditCode
fetch next from cur into @auditCode
end
close cur
deallocate cur

end