 
CREATE procedure [dbo].[PublishAudit] @AuditCode varchar(10)
as begin
 
declare @userid int,@Master_auditId int,@auditId int, @userCompID int

  select @userCompID=UserChecklistAuditInfoID from UserChecklistAuditInfos join [dbo].[Master_AuditInfo] A  on AuditCode=@AuditCode and UserID=A.[AssignedToUserUUID] and FBO= A.[AuditFBO] and LocationName= A.AuditLocation and City= A.AuditCity and LocationCode = A.AuditLocationCode

	  if @userCompID is null
	  begin
     insert into UserChecklistAuditInfos( [UserID] ,[FBO],[LocationName] ,[City] ,[Status],[CreatedBy],[CreatedDateTime],[LocationCode])
     select distinct A.[AssignedToUserUUID] ,A.[AuditFBO] ,A.AuditLocation,A.AuditCity,null,'0001-01-01','0001-01-01',A.AuditLocationCode
	 from  [dbo].[Master_AuditInfo] A where AuditCode=@AuditCode
	 and not exists(select 1 from UserChecklistAuditInfos where UserID=A.[AssignedToUserUUID] and FBO= A.[AuditFBO] and LocationName= A.AuditLocation 
	 and City= A.AuditCity and isnull(LocationCode,'') = isnull(A.AuditLocationCode,''))
	 end

select @userid=UserChecklistAuditInfoID from UserChecklistAuditInfos join [dbo].[Master_AuditInfo] A  on AuditCode=@AuditCode and UserID=A.[AssignedToUserUUID] and FBO= A.[AuditFBO] and LocationName= A.AuditLocation and City= A.AuditCity and LocationCode = A.AuditLocationCode
select @Master_auditId=AuditInfoID from [dbo].[Master_AuditInfo] where AuditCode=@AuditCode 
 
	 
	--1 insert in [Audit]
insert into [Audit] ( [AuditName],AuditCode,[AuditImage],AuditScheduledStartDateTime,[AuditScheduledEndDateTime],[AuditStatus], [AuditType],UserChecklistAuditInfoID,[AuditStartDateTime],[AuditEndDateTime],[AssignedDateTime],
[TotalNumberOfChecklist],[TotalOpenChecklist],[TotalDraftChecklist],[TotalClosedChecklist],[TotalNoChecks],[TotalNoOfChecks],[TotalYesChecks],[AuditScore],[AuditMaxScore],
[AuditCompliancePercentage],[Submitted],SubmittedDateTime,[Locked],[Synced],[SyncedDateTime],[AuditedBy])
select distinct AuditName,@AuditCode, AuditImage,AuditScheduledStartDateTime,	AuditScheduledEndDateTime,'Open',AuditType,@userid,'0001-01-01','0001-01-01','0001-01-01',
0,0,0,0,0,0,0,0,0,0,0,'0001-01-01',0,0,'0001-01-01',AssignedToUserName from [dbo].[Master_AuditInfo] where AuditCode=@AuditCode 
and not exists(select 1 from [Audit] where AuditCode = @AuditCode)

select @auditId=auditId from [dbo].[Audit] where AuditCode=@AuditCode 
  --insert into auditchecklist
	insert into [AuditChecklist] ([ChecklistName], [ChecklistMasterCode],ChecklistIcon, [ChecklistCategory], [ChecklistType],
				[ChecklistDescription], [ChecklistArea], [ChecklistSubArea], [ChecklistStatus], [AuditID],ChecklistScheduledStartDateTime,ChecklistScheduledEndDateTime,
				[ChecklistStartDateTime],[ChecklistEndDateTime],LastCheckPerformed,TotalNoOfChecks,TotalYesResponse,[TotalNoResponse],[TotalScore],[MaxScore],
				ChecklistCompliancePercentage,[Submitted],[SubmittedDateTime],[Synced],[SyncedDateTime],[Locked],[Pinned],[ChecklistSubAreaCode])

	select distinct ChecklistName ,ChecklistCode ,ChecklistIcon,[ChecklistCategory],[ChecklistType],ChecklistDescription  ,AreaName,	SubAreaName ,'Open'[ChecklistStatus],
	@auditId,ChecklistScheduledStartDateTime,	ChecklistScheduledEndDateTime,'0001-01-01','0001-01-01',0,0,0,0,0,0,0,0,'0001-01-01',0,'0001-01-01',0,0,macl.[SubAreaCode]
	 from [dbo].[Master_AuditCheck] mauc
	join [Master_AreaChecks] mac on mac.AreaChecksID=mauc.AreaChecksID and  mauc.AuditInfoID=@Master_auditId
	join [dbo].[Master_Checklist] mcl on mcl.ChecklistID=mac.ChecklistID
	join [dbo].[Master_AuditChecklistInfo] macl on macl.AuditChecklistInfoID=mauc.AuditChecklistInfoID
	and not exists( select 1 from [AuditChecklist] ac where  ac.AuditID = @auditId and ac.ChecklistMasterCode = mcl.ChecklistCode)
	--update checklistcode
	update AuditChecklist set ChecklistCode='CL'+right('00000'+convert(varchar(5),AuditChecklistID),6)
	where  ChecklistCode is null

	--3 insert into [AuditCheck]
	insert into [AuditCheck] ([CheckName], [CheckImage], [PerformedDateTime], [CheckScore], [CheckType],
				[AuditChecklistID], [CheckCode], [CheckAnswer],[CheckResponse],[CheckDescription])
	select  CheckTitle , [CheckImage], '0001-01-01',Score, [CheckType],ac.AuditChecklistID,[CheckCode],CheckAnswer,'NP',[CheckDescription]
	from [dbo].[Master_AuditCheck] mauc
	join [Master_AreaChecks] mac on mac.AreaChecksID=mauc.AreaChecksID and  mauc.AuditInfoID= @Master_auditId
	join Master_Checklist mcl on mcl.ChecklistID=mac.ChecklistID 
	join [dbo].[Master_Check] mc on mc.CheckID=mac.CheckID
	join AuditChecklist ac on ac.ChecklistMasterCode=mcl.ChecklistCode and ac.AuditID= @auditId and ac.[ChecklistSubAreaCode] = mac.[SubAreaCode]
	where not exists( select 1 from [AuditCheck] where AuditChecklistID = ac.AuditChecklistID and CheckCode = mc.CheckCode)
	
	update  acl	set MaxScore =  aclc.[maxscore],TotalNoOfChecks = aclc.TotalNoOfChecks
	 from (
		select acl.AuditChecklistID,sum(CheckScore) MaxScore,count(AuditCheckID)TotalNoOfChecks from [AuditCheck] ac
		join AuditChecklist acl on acl.AuditChecklistID = ac.AuditChecklistID and acl.AuditID=@auditId
		group by acl.AuditChecklistID
		)aclc  join AuditChecklist acl on acl.AuditChecklistID = aclc.AuditChecklistID and acl.AuditID=@auditId
		 

	update a
	set [TotalNumberOfChecklist] = acl.[TotalNoOFChecklist], [TotalOpenChecklist] = acl.[TotalNoOFChecklist],
	[TotalNoOfChecks] = acl.[TotalNoOfChecks], [AuditMaxScore] = acl.[maxscore] from (
		select AuditID,count(*) TotalNoOFChecklist,sum(TotalNoOfChecks) TotalNoOfChecks,sum(MaxScore) MaxScore from [AuditChecklist] acl
		where acl.AuditID=@auditId
	 group by AuditID)  acl join [dbo].[Audit] a on a.[AuditID] = acl.[AuditID]  and a.AuditID=@auditId
	  

	update [dbo].[Master_AuditInfo]
	set AuditStatus='Published' where AuditCode = @AuditCode

End