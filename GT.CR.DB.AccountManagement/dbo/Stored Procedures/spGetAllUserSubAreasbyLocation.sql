

 -- =============================================  
-- Author:  Mahesh Kumar  
-- ALTER date:  24-12-2018  
-- Description: To get all User's Areas by Location Code  
-- =============================================  
-- spGetAllUserSubAreasbyLocation 'UU0000002','MCD0000001','MCD0000001_01'  
CREATE Procedure [dbo].[spGetAllUserSubAreasbyLocation]   
 -- Add the parameters for the stored procedure here  
 @UUID nvarchar(20),  
 @LocationCode nvarchar(50),  
 @AreaCode nvarchar(50)  
  
AS  
BEGIN  
  
 SET NOCOUNT ON;  
  
   select distinct sainf.SubAreaCode, sainf.SubAreaName, sainf.Description SubAreaDescription  
 from [dbo].[UserTeamMapping]  ltm  
 join OfficeLocation ofl on ofl.OfficeLocationID=ltm.OfficeLocationID and ofl.[Status]='Active'  
 join LocationArea la on la.OfficeLocationID=ltm.OfficeLocationID and la.[Status]='Active'  
 join users on users.UUID=ltm.UUID  
 join UserAccountMappings uam on uam.userid=users.userid and uam.OfficeLocationID=ltm.OfficeLocationID and  uam.[Status]='Active'  
 join SubAreaInfo sainf on sainf.LocationAreaID=la.LocationAreaID   and sainf.[Status]='Active'
 where users.UUID=@UUID and ofl.OfficeLocationCode=@LocationCode and la.AreaCode=@AreaCode  
 and ltm.[Status]='Active'  
        
END  
   
   
  
   
  
  
