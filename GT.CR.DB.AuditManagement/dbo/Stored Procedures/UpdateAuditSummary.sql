CREATE procedure [dbo].[UpdateAuditSummary]
as begin
 
 
update a
set TotalNumberOfChecklist  = c from Audit a join (
select  AuditID,count(*) c from AuditChecklist
 group by AuditID)s
on a.AuditID=s.AuditID 

update a
set TotalNoOfChecks  = c from Audit a join (
select  AuditID,sum(TotalNoOfChecks) C from AuditChecklist
 group by AuditID)s
on a.AuditID=s.AuditID 



update a
set TotalYesChecks  = c from Audit a join (
select  AuditID, sum(TotalYesResponse) c from AuditChecklist
 group by AuditID )s
on a.AuditID=s.AuditID

update a
set TotalNoChecks  = c from Audit a join (
select  AuditID ,sum(TotalNoResponse) c from AuditChecklist
 group by AuditID )s
on a.AuditID=s.AuditID 



update a
set AuditScore  = c from Audit a join (
select  AuditID ,sum(TotalScore) c from AuditChecklist
 group by AuditID )s
on a.AuditID=s.AuditID 

update a
set AuditMaxScore  = c from Audit a join (
select  AuditID ,sum(MaxScore) c from AuditChecklist
 group by AuditID )s
on a.AuditID=s.AuditID 

update Audit 
set AuditCompliancePercentage=convert(int,(AuditScore/convert(float,AuditMaxScore))*100) 







End