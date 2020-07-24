-- =============================================
-- Author:		K ASHOK KUMAR
-- Create date: 15/12/2016
-- Description:	Verifies if the BusinessModule exist for a given BusinessModuleCode 
-- Returns 1 if the BusinessModule exist else returns 0
-- =============================================

CREATE Procedure [dbo].[spMasterIsBusinessModuleExistByBusinessModuleCode]
	@BusinessModuleCode varchar(20),
	@BusinessModuleExist BIT OUTPUT
	AS
BEGIN
	
	SET @BusinessModuleExist=0

	if exists(select BusinessModuleCode from [BusinessModules] where BusinessModuleCode=@BusinessModuleCode) 
	SET @BusinessModuleExist=1

	RETURN @BusinessModuleExist;
END














