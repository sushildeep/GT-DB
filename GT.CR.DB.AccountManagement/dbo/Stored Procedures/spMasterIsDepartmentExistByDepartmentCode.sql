
 
-- =============================================
-- Author:		K ASHOK KUMAR
-- Create date: 15/12/2016
-- Description:	Verifies if the department exist for a given departmentcode 
-- Returns 1 if the account exist else returns 0
-- =============================================

CREATE Procedure [dbo].[spMasterIsDepartmentExistByDepartmentCode]
	@departmentCode varchar(20),
	@departmentExist BIT OUTPUT
	AS
BEGIN
	
	SET @departmentExist=0

	if exists(select DepartmentCode from [Departments] where DepartmentCode=@departmentCode) 
	SET @departmentExist=1

	RETURN @departmentExist;
END














