-- =============================================
-- Author:		Abhinav Yadav
-- ALTER date: 14/12/2016
-- Description:	Procedure to return all the users who belong to a specific role in an account
-- =============================================
CREATE Procedure [dbo].[spGetAllUsersByRole]
	-- Add the parameters for the stored procedure here
	@roleCode nvarchar(20),
	@businessModuleCode nvarchar(20)=NULL,
	@accountCode nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 Declare @resultCount int =0;
    -- Insert statements for procedure here
		SELECT usr.UUID as UUID, (usr.First_Name+' '+usr.Last_Name) as Name, uc.contactValue Email, usr.username,
		usr.First_Name,usr.Last_Name,usr.[Middle_Name],usr.[Prefix],usr.[Suffix],usr.[UserType] into #temp
	FROM [dbo].[Users] usr 
	Inner Join [dbo].[UserRoles] usrol on usr.userid = usrol.userid
	Inner Join [dbo].[Roles] rol ON usrol.roleid=rol.roleid  
	join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=rol.[MasterRoleId] and mr.rolecode=@rolecode 
	inner join [dbo].[accountinfoes] acc on rol.accountid=acc.accountinfoid and acc.accountcode= @accountCode
	INNER JOIN [dbo].[UserContactInfo] uc
	on uc.userid=usr.userid
	and uc.[ContactType]='EMAIL' AND uc.[IsPrimary]=1
 	select @resultCount=count(*) from #temp
 
 	
	
	DECLARE @accountExist BIT,@RoleExist BIT;

EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT


if(@resultCount=0)
BEGIN
	IF(@accountExist=1) 
		
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

		-- LOB DOES NOT EXIST

		   -- Throw exception 

		   RAISERROR('LOB DOES NOT EXIST',16,1)

		END 
END
 else 
 begin
 select * from #temp
 end
IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL 
drop table #temp
END
--spGetAllUsersByRole 'RR0000002','','LOB000001'









