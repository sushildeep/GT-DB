
CREATE Procedure [dbo].[Sp_UpdateAuditCode] 
as begin

declare @newAudits [dbo].[List]  

Insert into @newAudits 
select [AuditInfoID]  from Auditinfo where AuditCode is null or AuditCode =''

update [dbo].[AuditInfo]
set AuditCode='A'+Right('000000'+convert(varchar(7),AuditInfoID),8)
where AuditCode is null or AuditCode =''


select Auditcode from auditinfo where [AuditInfoID] in (select input from @newAudits)
end