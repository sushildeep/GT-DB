
-- =============================================
-- Author:		K ASHOK KUMAR
-- Create date: 15/12/2016
-- Description:	Verifies if the user exist for a given UUID 
-- Returns 1 if the user exist else returns 0
-- =============================================

CREATE Procedure [dbo].[spMasterIsRoleExistByRoleCode]
	@RoleCode varchar(20),
	@RoleExist BIT OUTPUT
	AS
BEGIN
	
	SET @RoleExist=0

	if exists(select RoleCode   from [MasterRoles] where RoleCode=@RoleCode) 
	SET @RoleExist=1

	RETURN @RoleExist;
END














