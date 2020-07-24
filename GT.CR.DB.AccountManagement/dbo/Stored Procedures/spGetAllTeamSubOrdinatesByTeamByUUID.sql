
-- =============================================
-- Author:		K ASHOK KUMAR
-- ALTER date: 14/12/2016
-- Description:	Returns all team SubOrdinate users basic details for a given user under a specific team and under a user
-- Master Data Convention 
-- For [ParentOrChildID] : 0 - Parent , 1 - Child . e.g Team leads will have 0 and subordinates will have 1

-- =============================================
CREATE Procedure [dbo].[spGetAllTeamSubOrdinatesByTeamByUUID]

@teamCode varchar(20),@UUID varchar(20) 

AS
BEGIN

declare @teamExist bit;
EXEC [dbo].[spMasterIsTeamExistByTeamCode]  @teamCode, @teamExist = @teamExist OUTPUT
IF(@teamExist=0) 
		BEGIN
		RAISERROR('TEAM DOES NOT EXIST',16,1)
		END

	if exists(SELECT top 1 TeamMappingID FROM [TeamMappings] where [TeamID]=(SELECT [TeamID] FROM [Teams] where TeamCode=@teamCode) and [UUID]=@UUID) 
		
		BEGIN
		 
		 -- When User has access to the team

			-- Getting all subordinate users for the team users and returning from procedure
		(SELECT us.[UUID]
			,us.[First_Name]
			,us.[Last_Name]
			,us.[Middle_Name]
			,uc.contactValue [Email]
			,(us.First_Name+' '+us.Last_Name) as Name
			,us.username
			,us.[Prefix],us.[Suffix],us.[UserType] 
			FROM [TeamMappings] tm JOIN Users us on  tm.UUID=us.UUID and tm.[TeamID]=(SELECT [TeamID] FROM [Teams] where TeamCode=@teamCode) and tm.[TeamNodeType]='CHILD' 
			 INNER JOIN [dbo].[UserContactInfo] uc
			on uc.userid=us.userid
			and uc.[ContactType]='EMAIL' AND uc.[IsPrimary]=1)
		END
    else 
		BEGIN
		 
		-- User does not have access to the team 

		   -- Throw exception 

		   -- ?? Need to append the user and teamid which needs to be caugth by c# calling code and handled  

		   RAISERROR('USER ACCESS TO TEAM IS DENIED',16,1)

		END
END















