

-- =============================================
-- Author:		K ASHOK KUMAR
-- ALTER date: 14/12/2016
-- Description:	Returns all team users basic details for a given user under a specific team
-- =============================================
CREATE Procedure [dbo].[spGetAllTeamMembersByTeamByUUID]

@teamCode varchar(20),@UUID varchar(20) 

AS
BEGIN

	-- Validate the user has access to team or not 

	if exists(SELECT top 1 TeamMappingID FROM [TeamMappings] where [TeamID]=(SELECT [TeamID] FROM [Teams] where TeamCode=@teamCode) and [UUID]=@UUID) 
		
		BEGIN
DECLARE @resultCount INT=0;
		 
		 -- When User has access to the team

			-- Getting all users for the team users and returning from procedure

			(SELECT us.[UUID]
			,us.[First_Name]
			,us.[Last_Name]
			,us.[Middle_Name]
			,uc.contactValue [Email]
			,(us.First_Name+' '+us.Last_Name) as Name
			, us.username
			, us.Suffix, us.Prefix,us.UserType
			-- ?? Need to do change tm.UserID=us.userid to tm.UserID=us.UUID
			 
			FROM [dbo].[TeamMappings] tm JOIN Users us
			INNER JOIN [dbo].[UserContactInfo] uc
			on uc.userid=us.userid
			and uc.[ContactType]='EMAIL' AND uc.[IsPrimary]=1
			 on  tm.UUID=us.UUID and tm.[TeamID]=(SELECT [TeamID] FROM [Teams] where TeamCode=@teamCode))
			
			
  end
	
	else
	begin
DECLARE  @UUIDExist BIT,@teamExist BIT;

 	
EXEC [dbo].[spMasterIsUserExistByUUID] @UUID, @UserExist = @UUIDExist OUTPUT

	IF(@UUIDExist=1) 
	begin
 

 EXEC [dbo].[spMasterIsTeamExistByTeamCode] @teamCode, @teamExist = @teamExist OUTPUT

	IF(@teamExist=0) 
	begin
	 
 
		   RAISERROR('TEAM DOES NOT EXIST',16,1)

		END 
		 else 
		BEGIN

		-- User does not have access to the team 

		   -- Throw exception 

		   -- ?? Need to append the user and teamid which needs to be caugth by c# calling code and handled  

		   RAISERROR('USER ACCESS TO TEAM IS DENIED',16,1)
 
		END
 

		END 
	ELSE 
		BEGIN

		-- LOB DOES NOT EXIST

		   -- Throw exception 
	 

		   RAISERROR('UUID DOES NOT EXIST',16,1)

		END 
		 
   
END


end















