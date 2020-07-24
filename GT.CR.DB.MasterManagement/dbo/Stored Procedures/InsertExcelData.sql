CREATE procedure [dbo].[InsertExcelData]
as
begin

declare @AuditName	nvarchar(max),
@AuditImage 	nvarchar(max),
@AssignedToUserUUID	nvarchar(max),
@AuditLocation	nvarchar(max),	@AuditFBO 	nvarchar(max),
@AuditScheduledStartDateTime	nvarchar(max),
@AuditScheduledEndDateTime		nvarchar(max),
@AuditExpiryDateTime	nvarchar(max),
@AuditCity		nvarchar(max),
@AuditType		nvarchar(max),
@AuditCategory	nvarchar(max),
@ChecklistScheduledStartDateTime	nvarchar(max),
@ChecklistScheduledEndDateTime 	nvarchar(max),
@AreaName		nvarchar(max),
@SubAreaName		nvarchar(max),
@SubAreaCode 	nvarchar(max),
@ChecklistCode		nvarchar(max),
@CheckCode	nvarchar(max),
@AuditLocationCode 	nvarchar(max),
@AuditInfoID int,@AuditChecklistInfoID int

declare exceldata cursor for
select distinct * from [ScheduleDataExcel]
 open exceldata
 fetch next from exceldata into 
 @AuditName,@AuditImage 	,@AssignedToUserUUID	,@AuditLocation	,	@AuditFBO 	,@AuditScheduledStartDateTime	,
@AuditScheduledEndDateTime		,@AuditExpiryDateTime	,@AuditCity		,@AuditType		,@AuditCategory	,
@ChecklistScheduledStartDateTime	,@ChecklistScheduledEndDateTime 	,@AreaName		,@SubAreaName		,
@SubAreaCode 	,@ChecklistCode		,@CheckCode	,@AuditLocationCode
	while @@FETCH_STATUS=0
		begin


		--------********** [AuditInfo]  *****------
		set @AuditInfoID=null

		SELECT top 1 @AuditInfoID=[AuditInfoID] FROM [dbo].[AuditInfo] AI WHERE  @AuditName = AI.AuditName AND @AuditImage = AI.[AuditImage]   AND
		 @AssignedToUserUUID = AI.[AssignedToUserUUID]
	AND @AuditLocation = AI.[AuditLocation] AND @AuditFBO = AI.AuditFBO AND
	DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime,  @AuditScheduledStartDateTime,105)) = AI.[AuditScheduledStartDateTime] AND 
	  DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @AuditScheduledEndDateTime,105)) = AI.[AuditScheduledEndDateTime] AND 
	    DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime,  @AuditExpiryDateTime,105)) = AI.AuditExpiryDateTime AND 
	  @AuditType= AI.AuditType AND @AuditCity=AI.AuditCity AND @AuditCategory = AI.AuditCategory AND @AuditLocationCode = AI.AuditLocationCode

	  if @AuditInfoID is null
	  begin
 	INSERT INTO  [dbo].[AuditInfo]  ([AuditName],[AuditImage],[AssignedToUserName],[AssignedToUserUUID],[AuditLocation]
      ,[AuditFBO],[AuditScheduledStartDateTime],[AuditScheduledEndDateTime],[AuditExpiryDateTime],[AuditType]
      ,[AuditCity],[AuditCategory],[AuditStatus],[CreatedBy],[CreatedDateTime],AuditLocationCode)

	  SELECT @AuditName,@AuditImage,null,@AssignedToUserUUID,@AuditLocation
      ,@AuditFBO,
	  DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @AuditScheduledStartDateTime,105))[AuditScheduledStartDateTime],
	  DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @AuditScheduledEndDateTime,105)) [AuditScheduledEndDateTime],
	    DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @AuditExpiryDateTime,105)) [AuditExpiryDateTime],
	  @AuditType    ,@AuditCity,@AuditCategory,null,'Excel',CURRENT_TIMESTAMP,@AuditLocationCode 
	   
	  set @AuditInfoID=SCOPE_IDENTITY();
	  end

	  --UPDATE AUDITCODE
	    UPDATE [dbo].[AuditInfo]
set AuditCode='A'+Right('000000'+convert(varchar(6),AuditInfoID),7)
where AuditCode is null
	
	  ----******** AuditChecklistInfo ****-----

	  set @AuditChecklistInfoID=null

	 select top 1 @AuditChecklistInfoID=AuditChecklistInfoID from  AuditChecklistInfo Ac
 WHERE
   DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime,@ChecklistScheduledStartDateTime,105)) = AC.ChecklistScheduledStartDateTime AND 
	  DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @ChecklistScheduledEndDateTime,105)) = ac.ChecklistScheduledEndDateTime AND 
	  @AreaName= ac.AreaName AND  @SubAreaName = ac.SubAreaName
	   AND @SubAreaCode= ac.SubAreaName

	   if @AuditChecklistInfoID is null
	   begin

	  INSERT INTO AuditChecklistInfo([ChecklistScheduledStartDateTime],[ChecklistScheduledEndDateTime],[AreaName],[SubAreaName],[SubAreaCode])

 SELECT  DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @ChecklistScheduledStartDateTime,105))[ChecklistScheduledStartDateTime],
  DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()),convert(datetime, @ChecklistScheduledEndDateTime,105))[ChecklistScheduledEndDateTime],
 @AreaName,@SubAreaName,@SubAreaCode 
	
	set @AuditChecklistInfoID=SCOPE_IDENTITY();
	 end


	 ---*****
	 INSERT INTO AuditCheck( [AuditInfoID],[AuditChecklistInfoID],[AuditCheckInfoID],[AreaChecksID])

	 SELECT distinct  @AuditInfoID,@AuditChecklistInfoID,null,AreaChecksID
	FROM  Checklist c 
	JOIN [Check] CC 
	ON CC.CheckCode = @CheckCode and c.ChecklistCode = @ChecklistCode
	join AreaChecks arc  on arc.SubAreaCode = @SubAreaCode and c.ChecklistID=arc.ChecklistID and arc.CheckID=cc.CheckID
	where not exists
	(select top 1 1 from AuditCheck where [AuditInfoID]=@AuditInfoID and [AuditChecklistInfoID]=@AuditChecklistInfoID and [AreaChecksID]=arc.AreaChecksID)

	 fetch next from exceldata into 
 @AuditName,@AuditImage 	,@AssignedToUserUUID	,@AuditLocation	,	@AuditFBO 	,@AuditScheduledStartDateTime	,
@AuditScheduledEndDateTime		,@AuditExpiryDateTime	,@AuditCity		,@AuditType		,@AuditCategory	,
@ChecklistScheduledStartDateTime	,@ChecklistScheduledEndDateTime 	,@AreaName		,@SubAreaName		,
@SubAreaCode 	,@ChecklistCode		,@CheckCode	,@AuditLocationCode

		end
close exceldata
deallocate exceldata

  exec TRN_sp_PublishExcelAudits


end