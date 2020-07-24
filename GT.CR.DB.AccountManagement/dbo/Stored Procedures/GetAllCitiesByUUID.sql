create proc [dbo].[GetAllCitiesByUUID]
@uuid nvarchar(20)
as
begin
	select distinct lai.city from LocationAddressInfo lai
	join OfficeLocation ofl
	on lai.OfficeLocationID = ofl.OfficeLocationID and lai.Status = 'Active'
	join UserAccountMappings uam
	on uam.OfficeLocationID = ofl.OfficeLocationID
	join users
	on users.UserID = uam.UserID
	where users.UUID = @uuid
end
