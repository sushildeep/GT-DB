 -- spAddUserTeamMappings  'smitha.lowes@health1stservices.com','Health First','ComplyRite','Quality','SAVE','Lowe''s/5th Floor Café',null
CREATE Procedure [dbo].[spAddUserTeamMappings] 
 @UserName varchar(50),	
 @AccountName varchar(50),	
 @ModuleName varchar(50)=null, 
 @DeptName varchar(50)=null,	
 @TeamName varchar(50)=null, 
 @LocationName varchar(50)=null,	
 @ParentUserName varchar(50)=null

as begin

	if  exists (select 1 from UserAccountMappings where Userid=(select userid from users where UserName=@UserName) and BusinessModuleInfoID=(select [dbo].[getBusinessModuleInfoIDByName] (@AccountName,@ModuleName)))
		begin
		    insert into UserTeamMapping
			select (select TeamID from Teams where DepartmentID =(select DepartmentID from Departments where [Name]=@DeptName and BusinessModuleInfoID=(select [dbo].[getBusinessModuleInfoIDByName] (@AccountName,@ModuleName))))
			,(select UUID from users where UserName=@UserName),(select AccountCode from AccountInfoes where AccountName=@AccountName and Category='LOB')
			,null,(select UUID from users where UserName=@ParentUserName),'Active','AMTeam',getdate(),null,null
			,(select OfficeLocationID from OfficeLocation where OfficeLocationName=@LocationName and AccountInfoID=(select AccountInfoID from accountinfoes where AccountName=@AccountName and Category='LOB'))
		end

end