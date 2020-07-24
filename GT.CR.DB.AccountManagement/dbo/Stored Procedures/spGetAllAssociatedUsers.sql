-- =============================================
-- Author:		<Prasanna,AM Team>
-- Create date: <11-4-2017>
-- Description:	<spGetAllAssociatedUsers>
-- =============================================
	--  exec spGetAllAssociatedUsers  @accountCode='LOB000001' , @UUID ='UU0000012' , @roleCode='RR0000023', @moduleCode='BM0000001'
CREATE Procedure [dbo].[spGetAllAssociatedUsers]
	-- Add the parameters for the stored procedure here
	@moduleCode nvarchar(20)= null,
	@shouldFetchAllMemberInLOB bit=0,
	@roleCode nvarchar(20)=null,
	@UUID nvarchar(20),
	@accountCode nvarchar(100)
AS
BEGIN
declare @CanFetchAllUsersInLOB bit=0
	-- SET NOCOUNT ON added to prevent extra result sets from	
	SET NOCOUNT ON;

	-- Check if User Having the Privilege to get all the Users in a given LOB(@accountCode)
		-- set @CanFetchAllUsersInLOB=1 if the user having all the privilege to get all the users of a given LOB i.e. @accountCode


	SELECT DISTINCT	
	  [Users].UUID,
	  roles.roleName,
	  AccountCode,
	  CanFetchAllUsersInLOB = @CanFetchAllUsersInLOB
	  --into #temp
	  ,[BusinessModuleInfoes].BusinessModuleCode
	  ,[Users].username
	  FROM [dbo].[Users] 
		JOIN [dbo].[UserRoles] ON [Users].UserID=[UserRoles].UserID
		JOIN [dbo].[Roles]  ON [UserRoles].RoleID=[Roles].RoleID
		join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=[Roles].[MasterRoleId]
		JOIN [UserWorkGroups] ON [Users].UUID = [UserWorkGroups].UUID
		JOIN [WorkGroups] ON [WorkGroups].workGroupCode = [UserWorkGroups].WorkGroupCode
		JOIN [BusinessModuleInfoes] ON [WorkGroups].BusinessModuleInfoID =[BusinessModuleInfoes].BusinessModuleInfoID
		-- select * from UserWorkgroups
WHERE  
([WorkGroups].AccountCode in (@accountCode) and 
[WorkGroups].WorkGroupCode In (SELECT WorkGroupCode From [dbo].[UserWorkGroups] WHERE UUID in (@UUID))  )
and  ((@roleCode is  null )or (@roleCode is  not null and mr.RoleCode=@roleCode ))
and  ((@moduleCode is  null )or (@moduleCode is  not null and [BusinessModuleInfoes].BusinessModuleCode = @moduleCode ))


END




