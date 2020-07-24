CREATE procedure Sp_GetALlAttachementsForUser

@userid int,
@locationCode nvarchar(MAX),
@AuditScheduledStartDate datetime,
@AuditScheduledEndDate datetime,
@Month int,
@Year int

as
begin
 
select 
 Count(distinct t2.[AuditID])AuditCount
 , Count(distinct t3.[AuditChecklistID])ChecklistCount
 ,Count(distinct t4.[AuditCheckID])CheckCount
 , Count(distinct t5.[AttachementID])AttachementCount  
 from  [dbo].[UserChecklistAuditInfos] t1
join [dbo].[Audit] t2 on t2.[UserChecklistAuditInfoID] = t1.[UserChecklistAuditInfoID]
join  [dbo].[AuditChecklist] t3 on t3.[AuditID] = t2.[AuditID]
join [dbo].[AuditCheck] t4 on t4.[AuditChecklistID] = t3.[AuditChecklistID]
left join [dbo].[Attachement] t5 on t5.[AuditCheckID] = t4.[AuditCheckID]
where  
t1.[UserID]=@userid 
or t1.[LocationCode] = @locationCode
or t2.[AuditScheduledStartDateTime] >= @AuditScheduledStartDate
 or t2.[AuditScheduledEndDateTime] = @AuditScheduledEndDate
or Month(t2.[AuditScheduledStartDateTime]) = @Month
or Year(t2.[AuditScheduledStartDateTime]) = @Year
	 

end