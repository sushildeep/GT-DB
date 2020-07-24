

 -- =============================================  
-- Author:  Birunthadevi S
-- ALTER date:  28-05-2019
-- Description: To get all Locations by UUID and AccountCode
-- =============================================  
-- spGetAllUserLocationsbyUUIDAndAccount  'UU0000015','LOB000002' 
CREATE Procedure [dbo].[spGetAllUserLocationsbyUUIDAndAccount]
 -- Add the parameters for the stored procedure here  
 @UUID nvarchar(20),  
 @LOBCode nvarchar(20)  =null
AS  
BEGIN  
 Select  distinct ai.AccountCode,ai.AccountName,ofl.OfficeLocationCode,ofl.OfficeLocationName 
 from UserAccountMappings uam 
 join Users u  on u.UserID=uam.UserID
 join AccountInfoes ai on ai.AccountInfoID=uam.AccountInfoID
  join OfficeLocation ofl on ofl.OfficeLocationID=uam.OfficeLocationID AND ofl.AccountInfoID=ai.AccountInfoID
 where  u.UUID=@UUID and ( @LOBCode is null or ai.AccountCode=@LOBCode)
 
END