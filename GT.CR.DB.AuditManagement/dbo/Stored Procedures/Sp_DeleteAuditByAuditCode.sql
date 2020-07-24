--[Sp_DeleteAuditByAuditCode] 'A00000578'
CREATE procedure [dbo].[Sp_DeleteAuditByAuditCode]
@auditCode nvarchar(MAX) 
as begin 

delete atc from Audit a
left join auditchecklist ac on a.AuditID = ac.AuditID
 left join AuditCheck acc on ac.AuditChecklistID = acc.AuditChecklistID
left join Attachement atc on atc.AuditCheckID = acc.AuditCheckID
where a.AuditCode = @auditCode

delete acc from Audit a
  join auditchecklist ac on a.AuditID = ac.AuditID
   join AuditCheck acc on ac.AuditChecklistID = acc.AuditChecklistID 
where a.AuditCode = @auditCode

delete  ac from Audit a 
 join auditchecklist ac on a.AuditID = ac.AuditID
where  AuditCode = @auditCode 

delete from Audit  
where AuditCode =  @auditCode

end