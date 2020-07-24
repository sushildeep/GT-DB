create  PROCEDURE [dbo].[spInsertUserAccounts]
	@p_AccountID int=NULL,
	@p_UserID int=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL
AS
BEGIN

	SET NOCOUNT ON;

	If not exists(select * from UserAccounts
	where  isnull([AccountID],'12311231')=isnull(@p_AccountID,'12311231') and isnull([AccountID],'12311231')=isnull(@p_UserID,'12311231') and ISNULL([CreatedBy],'12311231') = ISNULL(@P_CreatedBy,'12311231') and ISNULL([CreatedDate],'12311231') = ISNULL(@P_CreatedDate,'12311231') and ISNULL([UpdatedBy],'12311231') = ISNULL(@P_UpdatedBy,'12311231') and ISNULL([LastModifiedDate],'12311231') = ISNULL(@P_LastModifiedDate,'12311231'))
	BEGIN
	  insert into [UserAccounts] ([AccountID], [UserID], [CreatedBy], [CreatedDate], [UpdatedBy], [LastModifiedDate])
	  values(@P_AccountID, @P_UserID, @P_CreatedBy, @P_CreatedDate, @P_UpdatedBy, @P_LastModifiedDate) ;
	END

	RETURN 1
END







