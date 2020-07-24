 -- GetAllLocationsByCityAndUUID 'UU0000015', 'Bengaluru' 
 CREATE PROCEDURE [dbo].[GetAllLocationsByCityAndUUID]
 @UUID nvarchar(20),
 @CityName nvarchar(20)
 as
 begin
  select distinct ofl.OfficeLocationCode, ofl.OfficeLocationName, ai.Accountcode as LobCode  from UserAccountMappings uam
 join users
 on users.userid = uam.UserID
 join OfficeLocation ofl
 on uam.OfficeLocationID = ofl.OfficeLocationID and uam.Status='Active'
 join AccountInfoes ai
 on	ai.AccountInfoId = ofl.AccountInfoID
 join LocationAddressInfo lai
 on lai.OfficeLocationID = ofl.OfficeLocationID and ofl.Status='Active'
 where users.UUID = @UUID and lai.city = @CityName and lai.Status='Active'

 end
