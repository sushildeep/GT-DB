CREATE Procedure [dbo].[spInsertRolePrivileges]
	@P_RoleID bigint=NULL,
	@P_AccountCode nvarchar(100)=NULL,
	@P_BusinessProcessInfoID bigint=NULL,
	@P_BusinessModuleInfoID bigint=NULL,
	@P_PrivilegeCode bigint=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL,
	@P_RolePrivilegeID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;
	
	select @P_RolePrivilegeID = min([RolePrivilegeID]) from [RolePrivileges]
	where ISNULL([RoleID],'12311231') = ISNULL(@P_RoleID,'12311231') and ISNULL([AccountCode],'12311231') = ISNULL(@P_AccountCode,'12311231') and ISNULL([BusinessProcessInfoID],'12311231') = ISNULL(@P_BusinessProcessInfoID,'12311231') and ISNULL([BusinessModuleInfoID],'12311231') = ISNULL(@P_BusinessModuleInfoID,'12311231') and ISNULL([PrivilegeCode],'12311231') = ISNULL(@P_PrivilegeCode,'12311231') and ISNULL([CreatedBy],'12311231') = ISNULL(@P_CreatedBy,'12311231') and ISNULL([CreatedDate],'12311231') = ISNULL(@P_CreatedDate,'12311231') and ISNULL([UpdatedBy],'12311231') = ISNULL(@P_UpdatedBy,'12311231') and ISNULL([LastModifiedDate],'12311231') = ISNULL(@P_LastModifiedDate,'12311231')

	If(@P_RolePrivilegeID is null)
	BEGIN
	  insert into [RolePrivileges] ([RoleID], [AccountCode], [BusinessProcessInfoID], [BusinessModuleInfoID], [PrivilegeCode], [CreatedBy], [CreatedDate], [UpdatedBy], [LastModifiedDate])
	  values(@P_RoleID, @P_AccountCode, @P_BusinessProcessInfoID, @P_BusinessModuleInfoID, @P_PrivilegeCode, @P_CreatedBy, @P_CreatedDate, @P_UpdatedBy, @P_LastModifiedDate) ;
	  SET @P_RolePrivilegeID = SCOPE_IDENTITY();
	END


	RETURN 1
END






