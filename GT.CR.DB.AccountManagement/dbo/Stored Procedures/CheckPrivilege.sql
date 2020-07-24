
-- =============================================
-- Author:		Maran
-- ALTER date: 07-12-2016
-- Description:	Check privilege of a user
-- =============================================
/*      Declare @hasPrivilege bit
    	exec [CheckPrivilege] 'BM0000010', 'UU0000007', 'CareManagement_CalypsoLyte_Adddoc', 'LOB000001' ,  @hasPrivilege output
		select @hasPrivilege
*/
CREATE Procedure [dbo].[CheckPrivilege] 
	-- Add the parameters for the stored procedure here
	@moduleCode nvarchar(20),
	@uuid nvarchar(20) ,
	@privilegeCode nvarchar(800) ,
	@accountCode nvarchar(20),
	@hasPrivilege bit output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Declare @Count int=0;

    -- Insert statements for procedure here

  SELECT @Count=Count(*)

 FROM [dbo].[UserPrivileges] AS UsrPrvlg
   JOIN [dbo].[Users] AS usr  ON UsrPrvlg.[UserID]=usr.[UserID]
   --JOIN [dbo].[BusinessModuleInfoes] ON UsrPrvlg.Privilege_BusinessModuleInfoID = [BusinessModuleInfoes].BusinessModuleInfoID

  Where (UsrPrvlg.[PrivilegeCode] = @privilegeCode AND UsrPrvlg.[AccountCode]=@accountCode AND usr.uuid=@uuid) 
and  UsrPrvlg.[BusinessModuleCode]=@moduleCode
 and UsrPrvlg.status='ACTIVE' 

    

if(@Count=0)
BEGIN
	DECLARE @accountExist BIT,@UserExist BIT;

EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

	IF(@accountExist=1) 
	begin
 

EXEC spMasterIsUserExistByUUID @UUID,@UserExist=@UserExist OUTPUT

IF(@UserExist=0) 
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
		SET @hasPrivilege= 0;
END 
   
 ELSE
  BEGIN  
	SET @hasPrivilege= 1;
  END
	
	
   
   RETURN @hasPrivilege;
END
 
 











