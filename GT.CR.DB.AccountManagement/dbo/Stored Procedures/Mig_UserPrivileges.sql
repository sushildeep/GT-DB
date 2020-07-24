   
Create procedure [dbo].[Mig_UserPrivileges] 
@username varchar(50)= null,@accountName varchar(50)=null,@modulename varchar(50)=null,@privilegeCode varchar(100)=null
as
begin
	select top 1000 username,accountname,BusinessModuleName,privilegecode from userprivileges up
	join users u on u.userid=u.userid
	and (@username is null or @username='' or (u.UserID=up.UserID and username like '%'+@username+'%'))
	join AccountInfoes ac on ac.AccountCode=up.AccountCode
	and (@accountName is null or @accountName='' or (accountName=@accountName and category='LOB'))
	join BusinessModuleInfoes bmi on up.Privilege_BusinessModuleInfoID=bmi.BusinessModuleInfoId
	join BusinessModules bm on bmi.BusinessModuleCode=bm.BusinessModuleCode
	join BusinessProcessInfoes bpi on bpi.BusinessProcessInfoId=bmi.BusinessProcessInfoID and bpi.AccountID=ac.accountinfoId
	and (@modulename is null or @modulename='' or (BusinessModuleName=@modulename)) 
	and (@privilegeCode is null or @privilegeCode='' or (privilegeCode=@privilegeCode)) 
end
  

