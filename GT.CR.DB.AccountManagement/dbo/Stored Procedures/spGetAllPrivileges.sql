-- =============================================
-- Author:		Maran
-- ALTER date: 07-12-2016
-- Description:	Check privilege of a user
-- =============================================
CREATE Procedure [dbo].[spGetAllPrivileges] --'UU0000007','LOB000001'
	-- Add the parameters for the stored procedure here
	@uuid varchar(250) ,
	@accountCode varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @resultCount int

    -- Insert statements for procedure here

select
 concat(usrPrvlg.PrivilegeCode,',',usrPrvlg.BusinessModuleCode)
 --usrPrvlg.PrivilegeCode
  'privilege'
  into #temp from [UserPrivileges] usrPrvlg 
inner join [Users] usr On usrPrvlg.UserID=usr.UserID and usr.[UUID]=@uuid and  usrPrvlg.[AccountCode]=@accountCode and [status] ='ACTIVE'


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
begin
drop table #temp
END
end






