-- =============================================
-- Author:		Abhinav Yadav
-- ALTER date: 27/12/2016
-- Description:	Returns list of users who have a specific role and belong to a business process of an account
--[spGetAllModuleUsersByRole]'BM0000002', 'RR0000005' , 'AC0000001'
-- =============================================
CREATE Procedure [dbo].[spGetAllModuleUsersByRole]  
	-- Add the parameters for the stored procedure here
	@businessModuleCode varchar(max),-- = 'BM0000002',
	@roleCode varchar(max), --='RR0000005' ,
	@accountCode varchar(max) --='AC0000001'
AS
BEGIN

 Declare @resultCount int =0;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT distinct
    usr.UUID as UUID,
    (usr.First_Name+' '+usr.Last_Name) as Name,
    uc.contactValue EMAIL,usr.First_Name,usr.Last_Name,usr.[Middle_Name],usr.[Prefix],usr.[Suffix],usr.[UserType],usr.username Into #temp
    FROM [dbo].[Users] usr 
    INNER JOIN [dbo].[UserRoles] urls
	  ON usr.UserID=urls.UserID
    INNER JOIN [dbo].[Roles] rls
	  ON urls.RoleID=rls.RoleID
	  join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=rls.[MasterRoleId]
    INNER JOIN [dbo].[UserAccountMappings] UA
	on usr.UserID= UA.UserID
	INNER JOIN [dbo].[AccountInfoes] acc
	ON UA.AccountID=acc.AccountInfoID
	AND acc.AccountCode=@accountCode
	INNER JOIN [dbo].[BusinessModuleInfoes] bmi
	ON UA.BusinessModuleInfoID=bmi.BusinessModuleInfoID and
	bmi.BusinessModuleCode=@businessModuleCode--'BM0000002'
	INNER JOIN [dbo].[UserContactInfo] uc
	on uc.userid=usr.userid
	and uc.[ContactType]='EMAIL' AND uc.[IsPrimary]=1
    WHERE mr.RoleCode=@roleCode--'RR0000005'
    

		select @resultCount=count(*) from #temp
   
if(@resultCount=0)
BEGIN
DECLARE @accountExist BIT,@BusinessModuleExist BIT,@RoleExist BIT=1;
EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

	IF(@accountExist=1) 
	begin
	
EXEC spMasterIsBusinessModuleExistByBusinessModuleCode @businessModuleCode,@businessModuleExist=@businessModuleExist OUTPUT

if(@businessModuleExist=1)  
		BEGIN



EXEC spMasterIsRoleExistByRoleCode @RoleCode,@RoleExist=@RoleExist OUTPUT

IF(@RoleExist=0) 
		BEGIN
		  
		-- ROLE does not exist

		   -- Throw exception 
	 

		   RAISERROR('ROLE DOES NOT EXIST',16,1)

		END

	END 
    ELSE 
		BEGIN

		-- BUSINESS MODULE does not exist

		   -- Throw exception  

		   RAISERROR('BUSINESS MODULE DOES NOT EXIST',16,1)

		END
		end
	ELSE 
		BEGIN

		-- LOB DOES NOT EXIST

		   -- Throw exception  

		   RAISERROR('LOB DOES NOT EXIST',16,1)

		END 
END
	 else
BEGIN 
 
select * from #temp 
 
END
IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL 
drop table #temp
END


/*
exec[spGetAllModuleUsersByRole] 'BM0000002','RR0000005','AC0000001'
 */

 --EXEC [dbo].[spGetAllModuleUsersByRole] 








