

 -- =============================================  
-- Author:  Mahesh Kumar  
-- ALTER date:  26-04-2019
-- Description: To get all Location User's by Manager
-- =============================================  
-- spGetAllLocationUserbyManager 'UU0000015','LOB000002' 
CREATE Procedure [dbo].[spGetAllLocationUserbyManager]
 -- Add the parameters for the stored procedure here  
 @UUID nvarchar(20),  
 @LOBCode nvarchar(20)  
 --@BMCode nvarchar(20),  
AS  
BEGIN  
  
 SET NOCOUNT ON;  
  
   select --distinct utm.Teamid, utm.UUID, utm.OfficeLocationID
   distinct acinf.accountcode, acinf.accountname, acinf.AccountAbbreviation, lai.City, ofl.OfficeLocationName, ofl.OfficeLocationCode, users.uuid, users.username, users.First_Name FirstName, users.Last_Name LastName
    from UserTeamMapping utm
  --join TeamSubAreaMapping tsam on tsam.OfficeLocationID=utm.OfficeLocationID and tsam.TeamID=utm.Teamid
  join OfficeLocation ofl on ofl.OfficeLocationID=utm.OfficeLocationID
  left join [LocationAddressInfo] lai on lai.officelocationid=ofl.OfficeLocationID and lai.[Status]='Active' 
  join Users on users.UUID=utm.UUID
  join AccountInfoes acinf on acinf.AccountCode=@LOBCode
  join UserLocationRole ulr on ulr.OfficeLocationID=utm.OfficeLocationID and ulr.userid=(select userid from users where uuid=utm.UUID) and ulr.roleid in ( select RoleID from roles where RoleName!='Manager')
  where utm.OfficeLocationID in ( select OfficeLocationID from UserLocationRole
  where userid=(select userid from users where uuid=@UUID) and roleid in ( select RoleID from roles
  where RoleName='Manager' and AccountID=(select AccountInfoID from [dbo].[AccountInfoes] where AccountCode=@LOBCode)))
  and utm.ParentOrChildID=@UUID and utm.Status='Active'
 
      

END  
   
   