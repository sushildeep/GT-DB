

CREATE Procedure [dbo].[spMasterIsBusinessModuleExistByAccountCode]
	@BusinessModuleCode varchar(20),
	@AccountCode varchar(20),
	@BusinessModuleExist BIT OUTPUT
	AS
BEGIN
	
	SET @BusinessModuleExist=0

	if exists(SELECT BusinessModuleCode
			 FROM [dbo].[BusinessProcessinfoes] BP
			join [dbo].[Businessmoduleinfoes] BM
			ON BP.BusinessProcessInfoID  =BM.BusinessProcessInfoID
			 join [dbo].[AccountInfoes] AC
			ON BP.AccountID=AC.AccountInfoID 
			 where AC.AccountCode=@AccountCode--'AC0000005'
			 and bm.BusinessModuleCode=@BusinessModuleCode--'BM0000002'
 ) 
	SET @BusinessModuleExist=1

	RETURN @BusinessModuleExist;
END










