
CREATE Procedure [dbo].[spDeleteUserRecords] 
 @UserName varchar(50)

as begin

delete [UserTeamMapping] where UUID=(select UUID from users where username =@UserName) or ParentOrChildID=(select UUID from users where username =@UserName) 
delete [UserPreferences] where userid=(select userid from users where username =@UserName)
delete [UserLocationRole] where userid=(select userid from users where username =@UserName)
delete [UserContactInfo] where userid=(select userid from users where username =@UserName)
delete [UserAdditionalAttributes] where userid=(select userid from users where username =@UserName)
delete [UserAddress] where userid=(select userid from users where username =@UserName)
delete [UserAccountMappings] where userid=(select userid from users where username =@UserName)
delete [AspNetUsers] where UserName=@UserName
delete [Users] where UserName=@UserName

end