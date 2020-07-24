-- =============================================
-- Author:		Akash Swarnkar
-- Create date: 15-07-2017
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetUserContactInfoByUserName] 
	-- Add the parameters for the stored procedure here
	@userName nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	print 1
    -- Insert statements for procedure here
	SELECT [UserContactInfo]
      ,[ContactType]
      ,[ContactValue]
      ,[IsPrimary]
      ,USERS.[UserID]
      ,USERCONTACTINFO.[CreatedBy]
      ,USERCONTACTINFO.[CreatedDate]
      ,USERCONTACTINFO.[UpdatedBy]
      ,USERCONTACTINFO.[LastModifiedDate] 
	  FROM [dbo].[Users] AS USERS
                inner join [dbo].[UserContactInfo] AS USERCONTACTINFO ON  
                USERS.[UserID] = USERCONTACTINFO.[UserID]  
                and USERS.[UserName] =@userName 
END

 

