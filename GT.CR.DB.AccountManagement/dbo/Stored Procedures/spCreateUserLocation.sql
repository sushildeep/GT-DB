-- [spCreateUserLocation] 'raghotham.narasimha@lowes.com','Health First','ComplyRite','Lowe''s/5th Floor Café','Manager'
CREATE Procedure [dbo].[spCreateUserLocation] 
 @UserName varchar(150),	
 @AccountName varchar(50),
 @BusinessModuleName varchar(50),	
 @LocationName varchar(50),
 @LocationRole varchar(50)

as begin

declare @userid int, @OfficeLocationID int, @AccountID int, @BusinessModuleInfoID int;
select @AccountID= AccountInfoID from accountinfoes where Category='LOB' and AccountName=@AccountName
select @userid= userid from users where username=@UserName
select @OfficeLocationID= OfficeLocationID from OfficeLocation where OfficeLocationName=@LocationName and [Status]='Active' and AccountInfoID=@AccountID
select @BusinessModuleInfoID= [dbo].[getBusinessModuleInfoIDByName](@AccountName,@BusinessModuleName)


	if not exists (select 1 from UserAccountMappings where UserID=@userid and OfficeLocationID=@OfficeLocationID and BusinessModuleInfoID=@BusinessModuleInfoID)
		begin		
		
			insert into UserAccountMappings
			select @userid,@OfficeLocationID, @AccountID, @BusinessModuleInfoID,0,(select distinct DeployemntTagName from useraccountmappings where BusinessModuleInfoID=@BusinessModuleInfoID),'Active','AMTeam',getdate(),null,null;
		
			if (@LocationRole is not null and @LocationRole!='')
			begin			
				exec [spMapUserLocationRoles] @userid, @LocationRole, @BusinessModuleInfoID, @OfficeLocationID
			end
		end

	--else if not exists (select 1 from UserAccountMappings where UserID=@userid and OfficeLocationID=@OfficeLocationID and BusinessModuleInfoID=@BusinessModuleInfoID and [status]='InActive')
	--	begin	  
	--		update UserAccountMappings
	--		set [Status]='Active'
	--		where UserID=@userid and OfficeLocationID=@OfficeLocationID and BusinessModuleInfoID=@BusinessModuleInfoID 
	--	end
   
end