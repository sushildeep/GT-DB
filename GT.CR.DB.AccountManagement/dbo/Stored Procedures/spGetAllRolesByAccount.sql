-- =============================================
-- Author:		Nitesh Suresh
-- ALTER date: 27/12/2016
-- Description:	Get All roles of an account
-- =============================================
CREATE Procedure [dbo].[spGetAllRolesByAccount] -- 'LOB000001'
	@AccountCode varchar(50)
AS
BEGIN

DECLARE @resultCount INT=0;

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT mr.RoleCode, Roles.RoleName into #temp FROM AccountInfoes INNER JOIN
	Roles ON AccountInfoes.AccountInfoID = Roles.AccountID
	join [dbo].[MasterRoles] mr on mr.[MasterRoleId]=[Roles].[MasterRoleId]
	where AccountInfoes.AccountCode = @AccountCode;
    -- Insert statements for procedure here



select @resultCount=count(*) from #temp 

IF(@resultCount=0)
BEGIN

	DECLARE @accountExist BIT

EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

		IF(@accountExist=0) 
		begin 
		-- LOB DOES NOT EXIST 
		   -- Throw exception 
	 		   RAISERROR('LOB DOES NOT EXIST',16,1) 
		END  
		END
		ELSE	 
		BEGIN 
				select  * from #temp 
		END

 IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL 
		begin
			drop table #temp
		 end 

end





