CREATE procedure [dbo].[Sp_GetChecklistInfo]
 
@AuditCode [dbo].[LastModified] readonly

AS
    BEGIN
        SELECT 
		 acl.AuditChecklistID 
		    ,a.UserChecklistAuditInfoID 
           ,acl.ChecklistName 
           ,acl.ChecklistCode 
           ,acl.ChecklistIcon 
           ,acl.ChecklistMasterCode 
           ,acl.ChecklistCategory 
           ,acl.ChecklistType 
           ,acl.LastCheckPerformed 
           ,acl.ChecklistObservation 
           ,acl.ChecklistDescription 
           ,acl.ChecklistScheduledStartDateTime 
           ,acl.ChecklistScheduledEndDateTime 
           ,acl.ChecklistStartDateTime 
           ,acl.ChecklistEndDateTime 
           ,acl.ChecklistDepartment 
           ,acl.ChecklistArea 
           ,acl.ChecklistSubArea 
           ,acl.PerformedBy 
           ,acl.PerformedRole 
           ,acl.ChecklistStatus 
           ,acl.TotalNoOfChecks 
           ,acl.TotalYesResponse 
           ,acl.TotalNoResponse 
           ,acl.TotalScore 
           ,acl.MaxScore 
           ,acl.ChecklistCompliancePercentage 
           ,acl.Submitted 
           ,acl.SubmittedDateTime 
           ,acl.Synced 
           ,acl.SyncedDateTime 
           ,acl.Locked 
           ,acl.Pinned 
           ,acl.AuditID 
		    , acl.[CreatedBy],
			   acl.[CreatedDateTime],
			   acl.[LastModifiedBy],
			   acl.[LastModifiedDateTime]
		 
        FROM  [dbo].[AuditChecklist] acl
             JOIN [dbo].[Audit] a ON a.[AuditID] = acl.[AuditID]
			 join @AuditCode ac on ac.[ParentCode] =a.AuditCode  
and ((ac.[Code] =acl.ChecklistCode and 'Open' = ac.CodeStatus and  ac.LastModifiedDateTime != acl.LastModifiedDateTime) 
			or  ac.[Code] != acl.ChecklistCode)

		 
    END;