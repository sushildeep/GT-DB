CREATE Procedure [dbo].[spGetAllAuditorsByLocationAndModule] @LobCode varchar(50), @LocationCode varchar(50), @BMCode varchar(50) 
as begin

select distinct users.First_Name FirstName, users.Last_Name LastName, users.Middle_Name MiddleName, users.UserName UserName, users.UUID, ainf.AccountAbbreviation
from UserAccountMappings uam
join users on users.UserID =uam.UserID 
join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID and bmi.BusinessModuleCode=@BMCode
join AccountInfoes ainf on ainf.AccountInfoID=uam.AccountInfoID and ainf.AccountCode=@LobCode
join OfficeLocation olc on olc.OfficeLocationID=uam.OfficeLocationID and olc.AccountInfoID=uam.AccountInfoID and olc.OfficeLocationCode=@LocationCode
join UserLocationRole ulr on ulr.UserID=uam.UserID and ulr.OfficeLocationID=uam.OfficeLocationID and ulr.[Status] = 'Active'
join Roles on roles.RoleID=ulr.RoleID and uam.BusinessModuleInfoID=roles.BusinessModuleInfoID
join MasterRoles mr on mr.MasterRoleId=roles.MasterRoleId --
where mr.RoleCode='RR0000001' or mr.RoleCode = 'RR0000004' and uam.[Status]='Active'
end
