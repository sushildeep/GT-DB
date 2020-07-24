-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE addOrUpdateUserSession
	-- Add the parameters for the stored procedure here
@username varchar(50), 
@sessionID varchar(50),
@AppName varchar(50),
@timeStamp datetime	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if exists(select * from [dbo].[UserSession] where username=@username and AppName =@AppName)
	begin
	update [UserSession]
	set sessionID=@sessionID,timeStamp=@timeStamp
	where username=@username and AppName =@AppName
	
	end
	else 
	begin
    -- Insert statements for procedure here
	insert into [dbo].[UserSession]
	SELECT @username , 
@sessionID ,
@AppName ,
@timeStamp 
END
end
