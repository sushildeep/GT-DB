
-- =============================================  
-- Author:  Mahesh Kumar  
-- ALTER date:  24-12-2018  
-- Description: To get all User's Areas by Location Code  
-- =============================================  
-- spGetAllUserAreasbyLocation 'UU0000002','MCD0000001'  
CREATE Procedure [dbo].[spGetAllUserAreasbyLocation]   
 -- Add the parameters for the stored procedure here  
 @UUID nvarchar(20),  
 @LocationCode nvarchar(25)  
  
AS  
BEGIN  
  
 SET NOCOUNT ON;  
  
   
 select distinct la.AreaCode, la.AreaName, la.Description AreaDescription, la.LocationAreaID  
 from [dbo].[UserTeamMapping]  ltm  
 join OfficeLocation ofl on ofl.OfficeLocationID=ltm.OfficeLocationID and ofl.[Status]='Active'  
 join LocationArea la on la.OfficeLocationID=ltm.OfficeLocationID and la.[Status]='Active'  
 join users on users.UUID=ltm.UUID  
 join UserAccountMappings uam on uam.userid=users.userid and uam.OfficeLocationID=ltm.OfficeLocationID and  uam.[Status]='Active'  
 where ofl.OfficeLocationCode=@LocationCode and users.UUID=@UUID  
 and ltm.[Status]='Active'  
   
        
END  
   
   
  
  
  
