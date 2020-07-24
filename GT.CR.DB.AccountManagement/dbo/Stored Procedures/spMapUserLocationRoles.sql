
CREATE Procedure [dbo].[spMapUserLocationRoles] 
 @userid varchar(150),		
 @LocationRole varchar(50),
 @BusinessModuleInfoID int,
 @OfficeLocationID int

as begin

declare @MasterRoleID int, @RoleID int;
select @MasterRoleID =masterroleid from masterroles where RoleName=@LocationRole and [Status]='Active'

	if exists (select @MasterRoleID)
		begin				
			select @RoleID=RoleID from [Roles] where BusinessModuleInfoID=@BusinessModuleInfoID and MasterRoleId=@MasterRoleID
			if not exists (select 1 from UserLocationRole where UserID=@userid and OfficeLocationID=@OfficeLocationID and RoleId=@RoleID)
			begin
				insert into UserLocationRole
				select @userid, @OfficeLocationID, @RoleID, 'Active','AMTeam', getdate(), null, null
			end			
		end	
			   
end