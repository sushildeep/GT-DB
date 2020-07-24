-- exec [spCloneUserForGT] 'GTDev@greentickft.com','TestUser','Dev Team',3
CREATE Procedure [dbo].[spCloneUserForGT] @username varchar(50),@fn varchar(50),@ln varchar(50),@OldUid int
as begin
declare  @tempuuid varchar(10)=concat(concat('UU',REPLICATE(0,7-(select top 1 len(userid) from users order by userid desc ))),replace((select top 1 uuid from users order by UserID desc),'UU','')+1)

--declare  @tempuuid varchar(10)= concat('UU000',replace((select top 1 uuid from users order by uuid desc),'UU','')+1)
print @tempuuid
 

 INSERT INTO [dbo].[Users]([UUID] ,[First_Name] ,[Last_Name] ,[CreatedBy] ,[CreatedDate] ,[UpdatedBy] ,[LastModifiedDate] ,[UserName],UserType )
 select @tempuuid,@fn,@ln,'AM Team',getdate(),'AM Team',getdate(),@username,'ApplicationUser'

 INSERT INTO [dbo].[AspNetUsers]   select newid(), @tempuuid,@username,1
      ,'AEB7lrm93MyOYO4qr0r7CgOFzv3ekoTAuqspwoU3hyH+ATiNKwB04ZX/QnebnTX4tg=='
      ,'0f6f3e3d-2a8f-4242-95fb-84a00ca669e3'
      ,null
      ,1
      ,0
      ,NULL, 1, 0,
       @username ,5

 INSERT INTO [dbo].[UserAccountMappings] --([AccountID],Userid,Createdby,createddate,[BusinessModuleInfoID],[status],[ModuleToggleOrder],[DeployemntTagName],OfficeLocationID)
select  (select top 1 userid from users where username=@username),[OfficeLocationID],[AccountInfoID],[BusinessModuleInfoID],[ModuleToggleOrder], [DeployemntTagName],[status],'AM Team',getdate(),null,null
from UserAccountMappings where [status]='Active' and userid =@OldUid --and BusinessModuleInfoId in (15,25)
 
 
 INSERT INTO [dbo].UserLocationRole
select (select top 1 userid from users where username=@username),[OfficeLocationID],[RoleID],[status],'AM Team',getdate(),null,null
 from UserLocationRole where [status]='Active' and userid =@OldUid --and RoleId=68

insert into [dbo].[UserPreferences]
SELECT  (select top 1 userid from users where username=@username)
      ,[AccountPreferenceID]
      ,[TimeZoneId]
      ,[FontId]
      ,[ThemeID],[DeployemntTagName],[OfficeLocationID],[RoleID]
  FROM [dbo].[UserPreferences] where userid =@OldUid --and AccountPreferenceID=10
 

  insert into [dbo].[UserContactInfo] select 'EMAIL',@username,1,
  (select top 1 userid from users where username=@username),'AM Team',getdate(),null,null


 INSERT INTO [dbo].[UserPrivileges]
select (select top 1 userid from users where username=@username),[AccountCode]
      ,privilege_BusinessModuleInfoID
      ,[PrivilegeCode]
      ,'AM Team',getdate(),'AM Team',getdate(),[BusinessModuleCode],status,null from [userPrivileges]
where userid=@OldUid --and privilege_BusinessModuleInfoId in (15,25)

insert into [dbo].[UserWorkGroups]
select 'AM Team',getdate(),'AM Team',getdate(),[WorkGroupCode],(select top 1 uuid from users where username=@username)
from [UserWorkGroups] where uuid=(select top 1 uuid from users where userid=@OldUid  )


insert into UserTeamMapping([TeamID], [UUID], [AccountCode], [TeamNodeType], [ParentOrChildID], [Status], [CreatedBy], [CreatedDate],[OfficeLocationID])
select distinct TeamID,(select top 1 uuid from users where username=@username),AccountCode,TeamNodeType,'0',[Status],'AMTeam',getdate(),OfficeLocationID
from UserTeamMapping 
where Status='Active' and uuid=(select top 1 uuid from users where userid=@OldUid)



end






















 












