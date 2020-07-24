-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
create PROCEDURE [dbo].[ADDCHECKLISTANDCHECK] 
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- insert into check
	insert into [dbo].[Master_Check]([CheckCode],[CheckTitle],[CheckDescription],[CheckAnswer],[CheckImage],[Score],[Status],[CreatedBy],
	[CreatedDateTime],[CheckType])
	select distinct null,[ChecksTitle],[CheckDescription],[CheckAnswer],[CheckImage],[CheckScore],null,null,CURRENT_TIMESTAMP [CreatedDateTime],CheckType  
	  from P_MasterChecklist X
	where not exists
	(select 1 from dbo.[Master_Check] c
	 where 
	     isnull(x.[ChecksTitle],'') = isnull(c.CheckTitle,'')
	and	 isnull(x.[CheckDescription],'')=isnull(c.[CheckDescription],'')
	 and isnull(x.CheckScore,'') = isnull(c.Score ,'')
	 and isnull(x.[CheckAnswer],'') = isnull(c.CheckAnswer,'')
	 and isnull(X.[CheckType],'') = isnull(c.[CheckType],'')
	 and isnull(x.CheckImage,'') = isnull(c.CheckImage,''))
	  
  
--update check code
	   
 update dbo.[Master_Check]
set CheckCode='CH'+right('000000'+convert( varchar(20),checkid),7)
where CheckCode is NULL

	  -- Insert into checklist
	  insert into [dbo].[Master_Checklist]([ChecklistCode],[ChecklistName],[ChecklistIcon],[ChecklistDescription],[TotalNoOfChecks],[MaxScore],
[Status],[ChecklistCategory],[ChecklistType],[CreatedBy],[CreatedDateTime])

select distinct null,ChecklistName,ChecklistImage,[Checklist Description],0,0,null,ChecklistCategory,ChecklistType,
null,CURRENT_TIMESTAMP [CreatedDateTime]  from P_MasterChecklist X
where not exists (
select 1 from dbo.[Master_Checklist] c
 where   isnull(X.ChecklistName,'') = isnull(c.ChecklistName ,'')
 and isnull(x.[Checklist Description],'') = isnull(c.ChecklistDescription,'') 
 and isnull(x.ChecklistImage,'') = isnull(c.ChecklistIcon,'')
 and isnull(x.ChecklistCategory,'') = isnull(c.ChecklistCategory,'')
 and isnull(X.[ChecklistType],'') = isnull(c.ChecklistType,''))
  

	  -- Update ChecklistCode
	  update dbo.[Master_Checklist]
set ChecklistCode='CL'+right('000000'+convert( varchar(20),ChecklistID),7)
where ChecklistCode is NULL

-- insert into subareachecks
  insert into [dbo].[Master_AreaChecks]([SubAreaCode],[CheckID],[ChecklistID])
select distinct [SubAreaCode],c.CheckID,cl.ChecklistID from P_MasterChecklist X
join dbo.[Master_Check] c on isnull(X.[ChecksTitle],'') = isnull(c.CheckTitle,'')
 and isnull(x.CheckScore,'') = isnull(c.Score,'')
  and isnull(x.[CheckAnswer],'') = isnull(c.CheckAnswer,'')
  and isnull(X.[CheckType],'') = isnull(c.[CheckType],'')
   and X.[SubAreaCode] is not null and ltrim(rtrim(X.[SubAreaCode]))!= ''
join dbo.[Master_Checklist] cl on 
 isnull(X.ChecklistName,'') = isnull(cl.ChecklistName ,'')
 and isnull(x.[Checklist Description],'') = isnull(cl.ChecklistDescription,'') 
 and isnull(x.ChecklistImage,'') = isnull(cl.ChecklistIcon,'')
 and isnull(x.ChecklistCategory,'') = isnull(cl.ChecklistCategory,'')
 and isnull(X.[ChecklistType],'') = isnull(cl.ChecklistType,'')

	  where not exists(
	  select 1 from [dbo].[Master_AreaChecks] where [SubAreaCode]= X.[SubAreaCode] and [CheckID] = c.CheckID and ChecklistID = cl.ChecklistID
	  )  
END