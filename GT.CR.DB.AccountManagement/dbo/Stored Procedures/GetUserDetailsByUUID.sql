-- GetUserDetailsByUUID @UUID='UU0000009'
CREATE Procedure [dbo].[GetUserDetailsByUUID] @UUID varchar(50)
as begin
declare @UserID int
set @UserID=(select userID from users where uuID=@UUID)


select 'UserBasicDetails,UserContactInformation,UserAddressInformation,UserAdditionalAttributes,UserPreferences,UserAccountMappings'

/* User Basic Info */
select distinct UUID,Gender,UserName,
DOB,First_Name,Middle_Name,Last_Name,Suffix,Prefix,Photo ProfilePicPath,Marital_Status,UserType 
from users 
where UserID=@UserID 

/* User Contact Info */
select distinct  ContactType,ContactValue,IsPrimary IsPrimaryContactType
from UserContactInfo 
where UserID=@UserID 

/* User Address Info */
select distinct AddressLine1 ,AddressLine2 ,Street ,City ,County ,State 
,Country ,ZipCode ,AddressType ,IsPrimary IsPrimaryAddress
from UserAddress 
where UserID=@UserID 

/* User Additional Attributes */
select distinct  AttributeName,	AttributeValue
from UserAdditionalAttributes 
where UserID=@UserID 

/* User Preferences */
select  users.First_Name as FirstName, users.Middle_Name as MiddleName, users.Last_Name as LastName,
users.uuid,users.UserName,ucinf.ContactValue Email, tprf.ThemePath,
AccountCode, OfficeLocationCode, ModuleCode, RoleCode, TimeZoneId, fprf.Size FontSize, fprf.Value FontValue
, tprf.ThemeName, uprf.DeployemntTagName DeploymentTagName
from userpreferences uprf
join AccountPreferences aprf on aprf.AccountPreferenceID=uprf.AccountPreferenceID
join OfficeLocation ofl on ofl.OfficeLocationID=uprf.OfficeLocationID
join FontPreferences fprf on fprf.FontID=uprf.FontId
join ThemePreferences tprf on tprf.ThemeID=uprf.ThemeID
left join roles on roles.RoleID=uprf.roleid
left join MasterRoles mr on mr.MasterRoleId=roles.MasterRoleId
join users on users.UserID=uprf.UserID
join UserContactInfo ucinf on ucinf.UserID=users.UserID and ucinf.ContactType='Email'
where ofl.[Status]='Active' and uprf.UserID=@UserID 

/* User Account Location Modules Roles */
select ainf.AccountCode, ainf.AccountName, oflc.OfficeLocationCode, oflc.OfficeLocationName 
, bm.BusinessModuleCode, bm.BusinessModuleName, mr.RoleCode, mr.RoleName
from UserAccountMappings uam
join AccountInfoes ainf on ainf.AccountInfoID=uam.AccountInfoID 
join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID
join BusinessModules bm on bm.BusinessModuleCode=bmi.BusinessModuleCode
join OfficeLocation oflc on oflc.OfficeLocationID=uam.OfficeLocationID and  oflc.[Status]='Active' -- oflc.AccountInfoID=uam.AccountInfoID 
left join UserLocationRole ulr on ulr.UserID=uam.UserID and ulr.OfficeLocationID=uam.OfficeLocationID
left join roles on  ulr.RoleID= roles.RoleID 
left join MasterRoles mr on mr.MasterRoleId=roles.MasterRoleId and mr.[Status]='Active'
where uam.Status='Active' and uam.UserID=@UserID


end



