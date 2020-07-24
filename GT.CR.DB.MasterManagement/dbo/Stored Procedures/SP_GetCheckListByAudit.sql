CREATE Procedure [dbo].[SP_GetCheckListByAudit] @auditId int as begin 
select cl.*,b.maxScore,b.CheckCount from
(

select cl.ChecklistID,ac.SubAreaCode,sum(c.Score) maxScore,count(c.CheckID) CheckCount   
from checklist cl
join AreaChecks ac on cl.ChecklistID = ac.ChecklistID
join AuditCheck auc on ac.AreaChecksID = auc.AreaChecksID
join AuditChecklistInfo aucl on aucl.AuditChecklistInfoID = auc.AuditChecklistInfoID 
join [check] c on c.CheckID=ac.CheckID
where AuditInfoID=@auditId
group by cl.ChecklistID,ac.SubAreaCode)b
join Checklist cl on cl.ChecklistID=b.ChecklistID
end