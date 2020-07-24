-- =============================================
-- Author:		K ASHOK KUMAR
-- Create date: 15/12/2016
-- Description:	Verifies if the team exist for a given teamcode 
-- Returns 1 if the team exist else returns 0
-- =============================================

CREATE Procedure [dbo].[spMasterIsTeamExistByTeamCode]
	@teamCode varchar(20),
	@teamExist BIT OUTPUT
	AS
BEGIN
	
	SET @teamExist=0

	if exists(select TeamCode from [Teams] where TeamCode=@teamCode) 
	SET @teamExist=1

	RETURN @teamExist;
END














