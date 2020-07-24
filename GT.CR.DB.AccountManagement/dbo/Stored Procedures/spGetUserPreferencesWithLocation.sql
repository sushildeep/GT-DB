-- exec [spGetUserPreferencesWithLocation] 'UU0000001','BM0000001'
CREATE Procedure [dbo].[spGetUserPreferencesWithLocation] 

	-- Add the parameters for the stored procedure here
	@UUID varchar(100),@BMCode varchar(100)=null,
@deploymentTagName varchar(200)='DEFAULT'
AS
begin
DECLARE @userExist BIT

EXEC spMasterIsUserExistByUUID @UUID, @userExist = @userExist OUTPUT

if(@userExist=1 and @BMCode is not null) 
	BEGIN 
			SELECT  top 1  Users.First_Name as FirstName, Users.Middle_Name as MiddleName, Users.Last_Name as LastName,Users.UUID,Users.UserName, 
			ap.ModuleCode, ap.AccountCode,up.TimeZoneId,uc.contactvalue 'EMAIL',up.DeployemntTagName DeploymentTagName,null RoleCode,
			theme.ThemeName,theme.ThemePath,font.Size FontSize ,font.Value FontValue,ol.OfficeLocationCode   --ol.OfficeLocationName
			FROM  Users INNER JOIN UserPreferences up ON up.UserID = Users.UserID	
			join usercontactinfo uc on uc.userid=users.userid and uc.contacttype='Email' and [IsPrimary]=1
			INNER JOIN AccountPreferences ap ON up.AccountPreferenceID = ap.AccountPreferenceID 
			and up.[AccountPreferenceID] =ap.[AccountPreferenceID]
			INNER JOIN [dbo].[ThemePreferences] theme ON up.ThemeID = theme.ThemeID 			
			INNER JOIN [dbo].[FontPreferences] font ON up.fontid = font.fontid	
			inner join officelocation ol on ol.OfficeLocationID=up.OfficeLocationID
			where DeployemntTagName like  '%'+@deploymentTagName +'%'		
			and Users.UUID = @UUID and ap.ModuleCode=@BMCode

				 
	END
else if(@userExist=1 and @BMCode is null) 
	BEGIN 
			SELECT  top 1  Users.First_Name as FirstName, Users.Middle_Name as MiddleName, Users.Last_Name as LastName,Users.UUID,Users.UserName, 
			ap.ModuleCode, ap.AccountCode,up.TimeZoneId,uc.contactvalue 'EMAIL',up.DeployemntTagName DeploymentTagName,null RoleCode,
			theme.ThemeName,theme.ThemePath,font.Size FontSize ,font.Value FontValue,ol.OfficeLocationCode
			FROM  Users INNER JOIN UserPreferences up ON up.UserID = Users.UserID	
			join usercontactinfo uc on uc.userid=users.userid and uc.contacttype='Email' and [IsPrimary]=1
			INNER JOIN AccountPreferences ap ON up.AccountPreferenceID = ap.AccountPreferenceID 
			and up.[AccountPreferenceID] =ap.[AccountPreferenceID]
			INNER JOIN [dbo].[ThemePreferences] theme ON up.ThemeID = theme.ThemeID 			
			INNER JOIN [dbo].[FontPreferences] font ON up.fontid = font.fontid	
			inner join officelocation ol on ol.OfficeLocationID=up.OfficeLocationID
			where DeployemntTagName like  '%'+@deploymentTagName +'%'		
			and Users.UUID = @UUID --and ap.ModuleCode=@BMCode

				 
	END
else 
	BEGIN

		-- User does not exist

		   -- Throw exception 

		   RAISERROR('UUID DOES NOT EXIST',16,1)

		END					

END
 


 
 --spGetUserPreferences 'UU0000038',''





