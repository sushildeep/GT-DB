CREATE procedure [dbo].[Sp_GetCheckInfo]
 
@AuditCode [dbo].[LastModified] readonly

AS
    BEGIN
        SELECT 
		acl.AuditCheckID
      ,[CheckCode]
      ,[CheckName]
      ,[CheckImage]
      ,[CheckResponse]
      ,[CheckAnswer]
      ,acl.PerformedBy
      ,[PerformedDateTime]
      ,[Remark]
      ,[CheckScore]
      ,[CheckType]
      ,[CheckCategory]
      ,[CheckStatus]
      ,acl.AuditChecklistID
      ,[CheckDescription]
      ,acl.CreatedBy
      ,acl.CreatedDateTime
      ,acl.LastModifiedBy
      ,acl.LastModifiedDateTime
		 
        FROM  [dbo].[AuditCheck] acl
             JOIN [dbo].[AuditChecklist] a ON a.AuditChecklistID = acl.AuditChecklistID
			 join @AuditCode ac on ac.[ParentCode] =a.ChecklistCode and ( ac.[Code] != acl.CheckCode
			 or ac.LastModifiedDateTime != acl.LastModifiedDateTime)

		 
    END;
	 
	  
 
--declare @AuditCode [dbo].[CodeStatus]  
-- insert into @AuditCode values('A00000257','CL000001','op') 
--Exec [Sp_GetChecklistInfo] @AuditCode