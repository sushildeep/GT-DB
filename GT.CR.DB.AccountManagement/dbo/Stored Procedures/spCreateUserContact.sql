
CREATE Procedure [dbo].[spCreateUserContact] 
 @UserName varchar(150),	
 @ContactType varchar(50),
 @ContactValue varchar(50),	
 @IsPrimary int=0


as begin

declare @userid int;
select @userid= userid from users where username=@UserName


  if not exists (select 1 from [UserContactInfo] where ContactType=@ContactType and ContactValue=@ContactValue and userid=@userid)
	  begin
		insert into [dbo].[UserContactInfo]
		select @ContactType,@ContactValue,@IsPrimary,@userid,'AMTeam',getdate(),null,null 
	  end

   
end