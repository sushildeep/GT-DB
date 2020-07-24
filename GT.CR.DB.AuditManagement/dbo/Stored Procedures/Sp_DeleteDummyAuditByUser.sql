CREATE procedure [dbo].[Sp_DeleteDummyAuditByUser] @UUID varchar(20)
as begin
declare auditCur cursor for
select a.AuditID from [dbo].[UserChecklistAuditInfos] u
join Audit a on a.UserChecklistAuditInfoID=u.UserChecklistAuditInfoID
where UserID=@UUID

declare @auditId int

Open auditCur
fetch next from auditCur into @auditId
while(@@FETCH_STATUS=0) 
begin
Exec Sp_DeleteDummyAudit @auditId
fetch next from auditCur into @auditId
end
close auditCur
deallocate auditCur
end