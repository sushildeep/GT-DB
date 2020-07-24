-- =============================================
-- Author:		<Author,,Name>
-- ALTER date: <ALTER Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [dbo].[spGetAllModuleRolesByAccount] 
	-- Add the parameters for the stored procedure here
	@uuid varchar(max),
	@accountCode varchar(max),
	@businessModuleCode varchar(max)
AS
BEGIN

DECLARE @resultCount INT=0;

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT distinct 
      rls.RoleID,
      mr.RoleCode,
      rls.RoleName INTO #temp
    FROM [dbo].[Roles] rls
    INNER JOIN [dbo].[UserRoles] urls
      ON rls.RoleID=urls.RoleID
	  join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=rls.[MasterRoleId]
    INNER JOIN [dbo].[Users] usr
      ON urls.UserID= usr.UserID
    INNER JOIN [dbo].[UserAccountMappings] ua
      ON usr.UserID=ua.UserID
    INNER JOIN [dbo].[AccountInfoes] acc
      ON ua.AccountID=acc.AccountInfoID AND rls.AccountID=acc.AccountInfoID
    INNER JOIN [dbo].[BusinessProcessInfoes] BPI
      ON acc.AccountInfoID=BPI.AccountID
    INNER JOIN [dbo].[BusinessModuleInfoes] BMI
      ON BPI.BusinessProcessInfoID=BMI.BusinessProcessInfoID
	--  and ua.BusinessModuleInfoID=BMI.BusinessModuleInfoID
    WHERE usr.uuid=@uuid--'UU0000123'
    AND acc.AccountCode=@accountCode--'AC0000001'
    AND BMI.BusinessModuleCode=@businessModuleCode--'BM0000002'

select @resultCount=count(*) from #temp
  
	DECLARE @accountExist BIT,@UUIDExist BIT,@businessModuleExist BIT;


if(@resultCount=0)
BEGIN

EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

	IF(@accountExist=1) 
	begiN
 

 EXEC spMasterIsBusinessModuleExistByBusinessModuleCode @businessModuleCode, @businessModuleExist = @businessModuleExist OUTPUT

	IF(@businessModuleExist=1) 
	begin
	 

EXEC spMasterIsUserExistByUUID @UUID,@userExist=@UUIDExist OUTPUT

IF(@UUIDExist=0) 
		BEGIN
		  
		-- ROLE does not exist

		   -- Throw exception 
		   
 
		   RAISERROR('UUID DOES NOT EXIST',16,1)

		END

	END 
	  
	 else
	 begin
 
		   RAISERROR('BUSINESS MODULE DOES NOT EXIST',16,1)

		END 
		END 
	ELSE 
		BEGIN

		-- LOB DOES NOT EXIST

		   -- Throw exception 
	 

		   RAISERROR('LOB DOES NOT EXIST',16,1)

		END 
END
	 else
begin 
select * from #temp 
	 
END
 
IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL 
drop table #temp
END





 
















