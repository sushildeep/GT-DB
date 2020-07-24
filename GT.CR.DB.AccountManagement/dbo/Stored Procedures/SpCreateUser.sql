
CREATE Procedure [dbo].[SpCreateUser] 
 @FirstName varchar(50),	
 @LastName varchar(50),	
 @MiddleName varchar(50)=null, 
 @Suffix varchar(50)=null,	
 @Prefix varchar(50)=null, 
 @Photo varchar(50)=null,	
 @DOB varchar(50)=null,	
 @UserName varchar(150),	
 @Gender varchar(50)=null, 
 @MaritalStatus varchar(50)=null,	
 @UserType varchar(50)='ApplicationUser'

as begin

declare  @tempuuid varchar(10)= concat(concat('UU',REPLICATE(0,7-(select top 1 len(userid) from users order by userid desc ))),replace((select top 1 uuid from users order by UserID desc),'UU','')+1)
----Old Code
--select concat('UU000',replace((select top 1 uuid from users order by uuid desc),'UU','')+1)  
 
print @tempuuid

 INSERT INTO [dbo].[Users]([UUID] ,[First_Name] ,[Last_Name] ,[CreatedBy] ,[CreatedDate] ,[UpdatedBy] ,[LastModifiedDate] ,[UserName]
 ,UserType, Middle_Name, Photo, DOB, Suffix, Prefix, gender, Marital_Status)
 select @tempuuid,@FirstName,@LastName,'AMTeam',getdate(),null,null,@username,@UserType,@MiddleName
 , @Photo, @DOB, @Suffix, @Prefix, @Gender, @MaritalStatus

 INSERT INTO [dbo].[AspNetUsers]   select newid(), @tempuuid,@username,1
      ,'AEB7lrm93MyOYO4qr0r7CgOFzv3ekoTAuqspwoU3hyH+ATiNKwB04ZX/QnebnTX4tg=='
      ,'0f6f3e3d-2a8f-4242-95fb-84a00ca669e3'
      ,null
      ,1
      ,0
      ,NULL, 1, 0,
       @username ,5 


  insert into [dbo].[UserContactInfo]select 'EMAIL',@username,1,
  (select top 1 userid from users where username=@username),'AM Team',getdate(),null,null 
   

end



