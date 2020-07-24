CREATE procedure [dbo].[UpdateCLSummary]
as begin

update AuditChecklist
set TotalYesResponse  =0,TotalNoResponse=0,TotalScore=0


update acl
set TotalNoOfChecks  = c from AuditChecklist acl join (
select  AuditChecklistID ,count(*) c from auditcheck 
group by AuditChecklistID )s
on acl.AuditChecklistID=s.AuditChecklistID



update acl
set TotalYesResponse  = c from AuditChecklist acl join (
select  AuditChecklistID, CheckResponse ,count(*) c from auditcheck
where CheckResponse='YES'
group by AuditChecklistID, CheckResponse )s
on acl.AuditChecklistID=s.AuditChecklistID

update acl
set TotalNoResponse = c from AuditChecklist acl join (
select  AuditChecklistID, CheckResponse ,count(*) c from auditcheck
where CheckResponse='NO'
group by AuditChecklistID, CheckResponse )s
on acl.AuditChecklistID=s.AuditChecklistID

update acl
set TotalScore  = c from AuditChecklist acl join (
select  AuditChecklistID, checkscore ,sum(checkscore) c from auditcheck 
where CheckResponse='YES'
group by AuditChecklistID, checkscore )s
on acl.AuditChecklistID=s.AuditChecklistID

update acl
set MaxScore  = c from AuditChecklist acl join (
select  AuditChecklistID, checkscore ,sum(checkscore) c from auditcheck 
group by AuditChecklistID, checkscore )s
on acl.AuditChecklistID=s.AuditChecklistID


update AuditChecklist
set ChecklistCompliancePercentage=convert(int,(TotalYesResponse/convert(float,MaxScore))*100) 
End