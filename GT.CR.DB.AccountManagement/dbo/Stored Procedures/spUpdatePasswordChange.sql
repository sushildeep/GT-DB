-- =============================================
-- Author:	 Hemanth
-- ALTER date: 31/07/2017
-- Description:	Procedure to Update the Password Changed Property for the User
-- =============================================
Create Procedure [dbo].[spUpdatePasswordChange]
	-- Add the parameters for the stored procedure here
	@uuid nvarchar(20) 
AS
BEGIN
 

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 Update AspnetUsers
	 set isPasswordChanged=1
	 where uuid=@uuid
END

 






