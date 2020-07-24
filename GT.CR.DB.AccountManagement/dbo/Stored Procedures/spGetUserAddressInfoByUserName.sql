-- =============================================
-- Author:		Mahesh Kumar
-- Create date: 31-07-2018
-- Description:	<Description,,>
-- =============================================

-- exec[spGetUserAddressInfoByUserName] 'mamatha.mishra@healthfirstservices.com' 
CREATE PROCEDURE [dbo].[spGetUserAddressInfoByUserName] 
	-- Add the parameters for the stored procedure here
	@userName nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select users.UUID,ua.AddressLine1,ua.AddressLine2,ua.street,ua.City,ua.County,ua.State,ua.Country,ua.ZipCode,
	ua.AddressType,ua.IsPrimary,ua.CreatedBy,ua.CreatedDate,ua.UpdatedBy,ua.LastModifiedDate
	from UserAddress ua
	join users on users.UserID=ua.userid
	where users.username=@userName 
	
END

 

