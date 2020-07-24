﻿CREATE PROCEDURE [dbo].[DeleteUserSession]
	-- Add the parameters for the stored procedure here
@username varchar(50), 
@sessionID varchar(50),
@AppName varchar(50)
--@timeStamp datetime	


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if exists(select * from [dbo].[UserSession] where username=@username and AppName =@AppName and sessionID=@sessionID)
	begin
	delete from [dbo].[UserSession] where username=@username and AppName =@AppName and sessionID=@sessionID
	select 'true'
	end
	else 
	begin
    -- Insert statements for procedure here
	select 'false'
END
end
