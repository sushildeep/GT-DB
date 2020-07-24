-- =============================================
-- Author:		Nitesh Suresh
-- ALTER date: 26/12/2016
-- Description:	To Get All users preferences
-- =============================================
CREATE Procedure [dbo].[spGetAllUserPreferences] 
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		--SELECT Users.UUID, Users.Email, Users.UserName, TimeCodes.TimeZoneUTC, TimeCodes.TimeZoneDTxt,
		--AccountPreferences.ModuleCode, AccountPreferences.AccountCode
		--FROM Users 
		--INNER JOIN UserPreferences ON UserPreferences.UserID = Users.UserID	
		--INNER JOIN AccountPreferences ON UserPreferences.AccountPreferenceID = AccountPreferences.AccountPreferenceID
		--INNER JOIN UserAccounts ON UserAccounts.AccountID=AccountPreferences.AccountPreferenceID
		--and UserAccounts.UserId=Users.UserId
		--INNER JOIN TimeCodes ON AccountPreferences.TimeCodeID = TimeCodes.TimeCodeID 			
		--where Users.UUID = @UUID;

		SELECT Users.UUID, Users.Email, Users.UserName, TimeCodes.TimeZoneUTC, TimeCodes.TimeZoneDTxt,
		AccountPreferences.ModuleCode, AccountPreferences.AccountCode
		FROM USER_ACCOUNT_INFORMATION Users
		INNER JOIN UserPreferences ON UserPreferences.UserID = Users.UserID	
		INNER JOIN AccountPreferences ON UserPreferences.AccountPreferenceID = AccountPreferences.AccountPreferenceID 
		and Users.accountcode =AccountPreferences.accountcode
		INNER JOIN TimeCodes ON AccountPreferences.TimeCodeID = TimeCodes.TimeCodeID 			
		--where Users.UUID = @UUID;
		--select * from users
END


--[spGetUserPreferences] 'uu0000525'













