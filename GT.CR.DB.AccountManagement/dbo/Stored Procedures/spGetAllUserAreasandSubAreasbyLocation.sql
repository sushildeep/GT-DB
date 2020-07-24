

 -- =============================================  
-- Author:  Mahesh Kumar  
-- ALTER date:  26-04-2019
-- Description: To get all User's Areas and Sub Areas by Location Code  
-- =============================================  
-- spGetAllUserAreasandSubAreasbyLocation 'UU0000001','MCD0000001'  --,'MCD0000001','BM00000001'
CREATE Procedure [dbo].[spGetAllUserAreasandSubAreasbyLocation]   
 -- Add the parameters for the stored procedure here  
 @UUID nvarchar(20),  
 @LocationCode nvarchar(50)
  --@LOBCode nvarchar(20),  
 --@BMCode nvarchar(20),  
AS  
BEGIN  
  
 SET NOCOUNT ON;  
  
   select distinct la.AreaCode, la.AreaName, sainf.SubAreaCode, sainf.SubAreaName
 from [dbo].[UserTeamMapping]  ltm  
 join OfficeLocation ofl on ofl.OfficeLocationID=ltm.OfficeLocationID and ofl.[Status]='Active'  
 join LocationArea la on la.OfficeLocationID=ltm.OfficeLocationID and la.[Status]='Active'  
 join users on users.UUID=ltm.UUID  
 join UserAccountMappings uam on uam.userid=users.userid and uam.OfficeLocationID=ltm.OfficeLocationID and  uam.[Status]='Active'  
 join SubAreaInfo sainf on sainf.LocationAreaID=la.LocationAreaID   and sainf.[Status]='Active'
 where users.UUID=@UUID and ofl.OfficeLocationCode=@LocationCode 
 and ltm.[Status]='Active'  
        
END  
   
   
  
   
  
  
