
CREATE Procedure [dbo].[SP_CreateUser] @username varchar(50),@fn varchar(50),@ln varchar(50) 
as begin
declare  @tempuuid varchar(10)= concat(concat('UU',REPLICATE(0,7-(select top 1 len(userid) from users order by userid desc ))),replace((select top 1 uuid from users order by UserID desc),'UU','')+1)
----Old Code
--select concat('UU000',replace((select top 1 uuid from users order by uuid desc),'UU','')+1)  
 


print @tempuuid
 

 INSERT INTO [dbo].[Users]([UUID] ,[First_Name] ,[Last_Name] ,[CreatedBy] ,[CreatedDate] ,[UpdatedBy] ,[LastModifiedDate] ,[UserName],UserType )
 select @tempuuid,@fn,@ln,'AM Team',getdate()   ,null,null,@username,'ApplicationUser'

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






















 












