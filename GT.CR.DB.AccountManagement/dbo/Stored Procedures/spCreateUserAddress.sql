
CREATE Procedure [dbo].[spCreateUserAddress] 

 @UserName varchar(150),		
 @AddressLine1 varchar(150),	
 @AddressLine2 varchar(150)=null,	
 @Street varchar(150),	
 @City varchar(150),	
 @District varchar(150),	
 @State varchar(150),	
 @Country varchar(150),	
 @ZipCode varchar(150),	
 @AddressType varchar(150),	 
 @IsPrimary int=0

as begin

declare @userid int;
select @userid= userid from users where username=@UserName


  if not exists (select 1 from UserAddress where AddressLine1=@AddressLine1 and AddressLine2=@AddressLine2 and street=@Street and City=@City
   and County=@District and [State]=@State and Country=@Country and ZipCode=@ZipCode and UserID=@userid and AddressType=@AddressType)
	  begin
		insert into [dbo].[UserAddress]
		select @AddressLine1,@AddressLine2,@Street,@City,@District,@State,@Country,@ZipCode,@userid,@AddressType,@IsPrimary,
		'AMTeam',getdate(),null,null 
	  end
   
end