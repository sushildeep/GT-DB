-- =============================================
-- Author:		Hemanth
-- ALTER date: 5/5/2017
-- Description:	Get User EmailAdresses by UserName
-- =============================================
CREATE Procedure [dbo].[spGetUserEmailbyUserName]
	-- Add the parameters for the stored procedure here
	@username nvarchar(200) 
AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select ContactValue'EMAIL'  from [dbo].[UserContactInfo]  where userid =
(select Top 1 userid from users where username =@username)
and ContactType='EMAIL' order by IsPrimary desc
END









