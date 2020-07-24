-- =============================================
-- Author:		K ASHOK KUMAR
-- Create date: 15/12/2016
-- Description:	Verifies if the account exist for a given accountcode 
-- Returns 1 if the account exist else returns 0
-- =============================================

CREATE Procedure [dbo].[spMasterIsAccountExistByAccountCode]
	@accountCode varchar(20),
	@accountExist BIT OUTPUT
	AS
BEGIN
	
	SET @accountExist=0

	if exists(select AccountCode from [AccountInfoes] where AccountCode=@accountCode) 
	SET @accountExist=1

	RETURN @accountExist;
END














