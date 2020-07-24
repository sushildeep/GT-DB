
-- =============================================
-- Author:		K ASHOK KUMAR
-- Create date: 15/12/2016
-- Description:	Verifies if the user exist for a given UUID 
-- Returns 1 if the user exist else returns 0
-- =============================================

CREATE Procedure [dbo].[spMasterIsUserExistByUUID]
	@UUID varchar(20),
	@userExist BIT OUTPUT
	AS
BEGIN
	
	SET @userExist=0

	if exists(select uuid from [Users] where UUID=@UUID) 
	SET @userExist=1

	RETURN @userExist;
END














