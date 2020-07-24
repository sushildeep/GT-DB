CREATE Procedure [dbo].[spGetAllAccountAbbByAccountModule]
	-- Add the parameters for the stored procedure here
	@accountCode varchar(max),
	@businessModuleCode varchar(max)
AS
BEGIN
DECLARE @resultCount INT=0;

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
--IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL 
--drop table #temp

select BMI.AccountAbbreviation from [BusinessModuleInfoes] BMI Inner Join 
[BusinessProcessInfoes] BPI ON BMI.[BusinessProcessInfoID]=BPI.[BusinessProcessInfoID] Inner join
[dbo].[AccountInfoes] AI ON BPI.[AccountID]=AI.[AccountInfoID] where
BMI.[BusinessModuleCode]=@businessModuleCode And
AI.[AccountCode]=@accountCode

--select @resultCount=count(*) from #temp
 
 	
--	DECLARE @accountExist BIT,@UUIDExist BIT,@businessModuleExist BIT;


--if(@resultCount=0)
--BEGIN

--EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

--	IF(@accountExist=1) 
--	begiN
 

-- EXEC spMasterIsBusinessModuleExistByBusinessModuleCode @businessModuleCode, @businessModuleExist = @businessModuleExist OUTPUT

--	IF(@businessModuleExist=0) 
--	begin
  
--		   RAISERROR('BUSINESS MODULE DOES NOT EXIST',16,1)

--		END 
--		END 
--	ELSE 
--		BEGIN

--		-- LOB DOES NOT EXIST

--		   -- Throw exception 
		    
--		   RAISERROR('LOB DOES NOT EXIST',16,1)

--		END 
--END
--else
--begin 
--select * from #temp 
	 
--END
 
END
 

 /*
exec [spGetAllAccountAbbByAccountModule] 'AC0000002','BM0000002'
 

 */

 










