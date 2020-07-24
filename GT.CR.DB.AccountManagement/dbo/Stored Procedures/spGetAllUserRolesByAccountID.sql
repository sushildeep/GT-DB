-- =============================================
-- Author:		Abhinav Yadav
-- ALTER date: 14/12/2016
-- Description:	To get all the roles of logged in user with for a specific account and Business Process
-- =============================================
CREATE Procedure [dbo].[spGetAllUserRolesByAccountID]
	-- Add the parameters for the stored procedure here
	@uuid nvarchar(20),
	@businessModuleCode nvarchar(20)=null,
	@accountCode nvarchar(20)
AS
BEGIN
DECLARE @resultCount INT=0;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT   mr.RoleCode RoleCode, rls.RoleName RoleName INTO #temp FROM [dbo].[Users] usr
INNER JOIN [dbo].[UserRoles] usrRls on usr.[UserID]=usrRls.[UserID] and usr.[UUID]=@uuid
INNER JOIN [dbo].[Roles] rls on usrRls.[RoleID] =rls. [RoleID]
join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=rls.[MasterRoleId]
INNER JOIN [dbo].[AccountInfoes] acc on rls.AccountID=acc.AccountInfoID and acc.AccountCode=@accountCode

select @resultCount=count(*) from #temp
  
	DECLARE @accountExist BIT,@UUIDExist BIT;


if(@resultCount=0)
BEGIN

EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

	IF(@accountExist=1) 
	begin
 

EXEC spMasterIsUserExistByUUID @UUID,@userExist=@UUIDExist OUTPUT

IF(@UUIDExist=0) 
		BEGIN
		  
		-- UUID does not exist

		   -- Throw exception 
		   
		   RAISERROR('UUID DOES NOT EXIST',16,1)

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


 












