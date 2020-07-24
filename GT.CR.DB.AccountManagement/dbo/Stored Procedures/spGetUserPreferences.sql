CREATE Procedure [dbo].[spGetUserPreferences] 
	-- Add the parameters for the stored procedure here
	@UUID varchar(100),
@deploymentTagName varchar(200)='DEFAULT'
AS
begin
DECLARE @userExist BIT

EXEC spMasterIsUserExistByUUID @UUID, @userExist = @userExist OUTPUT



if(@userExist=1) 
	BEGIN 
			SELECT  top 1 Users.UUID,Users.UserName, 
			ap.ModuleCode, ap.AccountCode,up.TimeZoneId,uc.contactvalue 'EMAIL',
			theme.ThemeName,theme.ThemePath,font.Size FontSize ,font.Value FontValue
			FROM  Users INNER JOIN UserPreferences up ON up.UserID = Users.UserID	
			join usercontactinfo uc on uc.userid=users.userid and uc.contacttype='Email' and [IsPrimary]=1
			INNER JOIN AccountPreferences ap ON up.AccountPreferenceID = ap.AccountPreferenceID 
			and up.[AccountPreferenceID] =ap.[AccountPreferenceID]
			INNER JOIN [dbo].[ThemePreferences] theme ON up.ThemeID = theme.ThemeID 			
			INNER JOIN [dbo].[FontPreferences] font ON up.fontid = font.fontid	
			where DeployemntTagName like  '%'+@deploymentTagName +'%'		
			and Users.UUID = @UUID; 
				 
	END
else 
	BEGIN

		-- User does not exist

		   -- Throw exception 

		   RAISERROR('UUID DOES NOT EXIST',16,1)

		END					

END
 


 
 --spGetUserPreferences 'UU0000038',''





