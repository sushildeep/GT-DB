CREATE procedure [dbo].[Sp_GetAuditInfo]
@UUID [dbo].[List] readonly,
@Role nvarchar(MAX),
@FBOCode nvarchar(MAX),
@AuditCode [dbo].[LastModified] readonly,
@StartDate datetime2 null,
@EndDate datetime2 null

AS
    BEGIN
        SELECT a.[AuditID],
		 a.UserChecklistAuditInfoID, 
               u.UserID, 
               a.AuditName, 
               u.[FBO] AS AuditFBO, 
			   u.[FBOCode],
               a.AuditCode, 
               a.AuditImage, 
               u.[LocationName] AS AuditLocation, 
               u.[City] AS AuditCity, 
			   u.LocationCode,
               a.AuditStartDateTime, 
               a.AuditObservation, 
               a.AuditEndDateTime, 
               a.AuditScheduledStartDateTime, 
               a.AuditScheduledEndDateTime, 
               a.AuditedBy, 
               a.AuditedByRole, 
               a.AssignedBy, 
               a.AuditStatus, 
               a.TotalNumberOfChecklist, 
               a.TotalOpenChecklist, 
               a.TotalDraftChecklist, 
               a.TotalClosedChecklist, 
               a.TotalNoOfChecks, 
               a.TotalYesChecks, 
               a.TotalNoChecks, 
               a.AuditScore, 
               a.AuditMaxScore, 
               a.AuditCompliancePercentage, 
               a.Submitted,  
			   a.SubmittedDateTime,
			   a.SyncedDateTime,
               a.Locked,  
               a.Synced, 
               a.AuditType, 
               a.AuditCategory, 
               a.CertificateID, 
               a.ScheduleID,
			   a.[CreatedBy],
			   a.[CreatedDateTime],
			   a.[LastModifiedBy],
			   a.[LastModifiedDateTime]
        FROM [dbo].[UserChecklistAuditInfos] u
             JOIN [dbo].[Audit] a ON u.[UserChecklistAuditInfoID] = a.[UserChecklistAuditInfoID]
			 and ((@Role ='Manager' and (a.AuditStatus != 'Open' and a.AuditStatus != 'inprogress') ) or @Role !='Manager') 
			 and ((a.AuditScheduledStartDateTime >= @StartDate and   a.AuditScheduledStartDateTime <= @EndDate ) or
			 (a.AuditScheduledEndDateTime >= @StartDate and a.AuditScheduledEndDateTime <= @EndDate))
			 join @UUID ui on u.userid=ui.[input] and u.[FBOCode] = @FBOCode
			 left join @AuditCode ac on (ac.[Code] =a.auditcode and ac.LastModifiedDateTime = a.LastModifiedDateTime 
			  and (a.AuditStatus = ac.CodeStatus )or (ac.[Code] =a.auditcode and'Open' != ac.Codestatus))
			 where ac.[Code] is null
    END;