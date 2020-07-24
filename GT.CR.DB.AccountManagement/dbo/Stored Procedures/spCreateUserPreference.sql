
CREATE Procedure [dbo].[spCreateUserPreference] 

 @UserName varchar(150),		
 @AccountName varchar(150),	
 @ModuleName varchar(150),
 @LocationName varchar(150),	
 @LocationRole varchar(150)

as begin

declare @userid int;
select @userid= userid from users where username=@UserName


	if exists (select 1 from UserAccountMappings where Userid=@userid and BusinessModuleInfoID=(select [dbo].[getBusinessModuleInfoIDByName] (@AccountName,@ModuleName))
	and OfficeLocationID=(select OfficeLocationID from OfficeLocation where OfficeLocationName=@LocationName and AccountInfoID=(select AccountInfoID from accountinfoes where AccountName=@AccountName and Category='LOB')
	))
		begin
				
			insert into UserPreferences
			select @userid,
			(select AccountPreferenceID from AccountPreferences where AccountCode=(select AccountCode from AccountInfoes where AccountName=@AccountName and Category='LOB')	and ModuleCode=(select BusinessModuleCode from BusinessModules where BusinessModuleName=@ModuleName))
			, 'India Standard Time',1,2,
			(select top 1 DeployemntTagName from UserAccountMappings where Userid=@userid and BusinessModuleInfoID=(select [dbo].[getBusinessModuleInfoIDByName] (@AccountName,@ModuleName)) and [Status]='Active')
			,(select OfficeLocationID from OfficeLocation where OfficeLocationName=@LocationName and AccountInfoID=(select AccountInfoID from accountinfoes where AccountName=@AccountName and Category='LOB'))
			,(select RoleID from Roles where RoleName=@LocationRole and BusinessModuleInfoID=(select [dbo].[getBusinessModuleInfoIDByName] (@AccountName,@ModuleName)))

		end
   
end