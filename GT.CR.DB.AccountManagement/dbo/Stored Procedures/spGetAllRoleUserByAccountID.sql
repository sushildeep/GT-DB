-- =============================================
-- Author:		Abhinav Yadav	
-- ALTER date: 14/12/2016
-- Description:	Procedure to get all users w.r.t. roles for a specific account and business module
-- =============================================
CREATE Procedure [dbo].[spGetAllRoleUserByAccountID] 
	-- Add the parameters for the stored procedure here
	@businessModuleCode nvarchar(20)=NULL,
	@accountCode nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @resultCount INT=0;

SELECT mr.RoleCode, rls.RoleName,usr.UUID as UUID,(usr.First_Name+' '+usr.Last_Name) as Name, uc.contactValue Email, 
usr.First_Name First_Name,usr.Last_Name Last_Name,usr.Middle_Name Middle_Name,usr.suffix,usr.prefix,usr.UserType,usr.username
into #temp
FROM [dbo].[Users] usr 
INNER JOIN [dbo].[UserRoles] usrRls on usr.[UserID]=usrRls.[UserID]
INNER JOIN [dbo].[Roles] rls on usrRls.[RoleID] =rls. [RoleID]
join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=rls.[MasterRoleId]
INNER JOIN [dbo].[AccountInfoes] acc on rls.AccountID=acc.AccountInfoID and acc.AccountCode=@accountCode
INNER JOIN [dbo].[UserContactInfo] uc
	on uc.userid=usr.userid
	and uc.[ContactType]='EMAIL' AND uc.[IsPrimary]=1

select @resultCount=count(*) from #temp
 
 	
	DECLARE @accountExist BIT,@UUIDExist BIT,@businessModuleExist BIT;


if(@resultCount=0)
BEGIN
    
EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

	IF(@accountExist=0) 
	begiN
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
















