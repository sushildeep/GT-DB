CREATE procedure [dbo].[Sp_UpdateAuditScore]
as begin

/*******************************  updating the AuditChecklist Table  *****************************************/

--Updating the Response count in AuditChecklist
update AuditChecklist
set TotalYesResponse  =0,TotalNoResponse=0,TotalScore=0 

-- updating the total number of checks
update acl
set TotalNoOfChecks  = c from AuditChecklist acl join (
select  AuditChecklistID ,count(*) c from auditcheck 
group by AuditChecklistID )s
on acl.AuditChecklistID=s.AuditChecklistID

--updating Yes Response

update acl
set TotalYesResponse  = c from AuditChecklist acl join (
select  AuditChecklistID, CheckResponse ,count(*) c from auditcheck
where CheckResponse='YES'
group by AuditChecklistID, CheckResponse )s
on acl.AuditChecklistID=s.AuditChecklistID

--updating No Response
update acl
set TotalNoResponse = c from AuditChecklist acl join (
select  AuditChecklistID, CheckResponse ,count(*) c from auditcheck
where CheckResponse='NO'
group by AuditChecklistID, CheckResponse )s
on acl.AuditChecklistID=s.AuditChecklistID


--updating Total Response
update acl
set TotalScore  = c from AuditChecklist acl join (
select  AuditChecklistID, checkscore ,sum(checkscore) c from auditcheck 
where CheckResponse='YES'
group by AuditChecklistID, checkscore )s
on acl.AuditChecklistID=s.AuditChecklistID

--updating Max Score  
update acl
set MaxScore  = c from AuditChecklist acl join (
select  AuditChecklistID, checkscore ,sum(checkscore) c from auditcheck 
group by AuditChecklistID, checkscore )s
on acl.AuditChecklistID=s.AuditChecklistID

--updating complaint Percentage
update AuditChecklist
set ChecklistCompliancePercentage=convert(int,(TotalYesResponse/convert(float,MaxScore))*100) 


/************************************  Updating Audit Table ************************************/



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