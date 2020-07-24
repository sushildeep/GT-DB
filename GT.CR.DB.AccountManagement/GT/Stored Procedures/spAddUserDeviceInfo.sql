-- =============================================
-- Author:		<Prasanna>
-- Create date: <13/2/2019>
-- Description:	<Adding User Module Mapping>
-- =============================================
CREATE Procedure [GT].[spAddUserDeviceInfo]
(
@UUID varchar(20),
@DeviceInformtion varchar(150)

) as
begin

--insert into [dbo].[UserAccountMappings]
	insert into DeviceInfo(UUID, [DeviceDetails],LoginTime ) values(@UUID, @DeviceInformtion, GETUTCDATE())

end