--Sp_DeleteDummyAudit 41
CREATE procedure [dbo].[Sp_DeleteDummyAudit]
@auditId int 
as begin 

delete atc from Audit a
left join auditchecklist ac on a.AuditID = ac.AuditID
 left join AuditCheck acc on ac.AuditChecklistID = acc.AuditChecklistID
left join Attachement atc on atc.AuditCheckID = acc.AuditCheckID
where a.AuditID = @auditId

delete acc from Audit a
  join auditchecklist ac on a.AuditID = ac.AuditID
   join AuditCheck acc on ac.AuditChecklistID = acc.AuditChecklistID 
where a.AuditID = @auditId

delete  auditchecklist  
where  AuditID = @auditId 

delete from Audit  
where AuditID =  @auditId

end