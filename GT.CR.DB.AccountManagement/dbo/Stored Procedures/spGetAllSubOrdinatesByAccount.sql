
-- =============================================
-- Author:		Nitesh Suresh
-- ALTER date: 26/12/2016
-- Description:	This procedure will get all the sub-ordinates under a give user of account and modules irrespective of teams 
-- =============================================
--	[spGetAllSubOrdinatesByAccount] 'UU0000007','LOB000001','BM0000001'
CREATE Procedure [dbo].[spGetAllSubOrdinatesByAccount]
	@UUID varchar(100),
	@AccountCode varchar(100),
	@ModuleCode varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @resultCount INT=0;

SELECT usr.[UUID],uc.contactValue [Email],usr.[UserName],usr.[First_Name],usr.[Last_Name],usr.[Middle_Name]
,(usr.First_Name+' '+usr.Last_Name) as Name INTO #temp
  FROM [dbo].[Users] usr 
  INNER JOIN [dbo].[UserContactInfo] uc
	on uc.userid=usr.userid
	and uc.[ContactType]='EMAIL' AND uc.[IsPrimary]=1
  where usr.[UUID] IN (SELECT [UUID]
  FROM [dbo].[TeamMappings] As TM
  INNER JOIN [dbo].[UserTeams] As UT
  ON [TM].[TeamID] = [UT].[TeamID]
  where [TM].[TeamNodeType] = 'CHILD' and [TM].[UUID] = @UUID and UT.[AccountCode] = @AccountCode
  and [UT].[BusinessModuleInfoID] IN 
  (SELECT [BusinessModuleInfoID] from [dbo].[BusinessModuleInfoes]
	where [BusinessModuleCode] = @ModuleCode  
  ));



select @resultCount=count(*) from #temp
  
	DECLARE @accountExist BIT,@UUIDExist BIT,@businessModuleExist BIT;


if(@resultCount=0)
BEGIN

EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT

	IF(@accountExist=1) 
	begiN
 

 EXEC spMasterIsBusinessModuleExistByBusinessModuleCode @ModuleCode, @businessModuleExist = @businessModuleExist OUTPUT

	IF(@businessModuleExist=1) 
	begin



	
EXEC spMasterIsUserExistByUUID @UUID,@userExist=@UUIDExist OUTPUT

IF(@UUIDExist=0) 
		BEGIN
		  
		-- ROLE does not exist

		   -- Throw exception 
	 

		   RAISERROR('UUID DOES NOT EXIST',16,1)

		END

	END 
    

	ELSE
	BEGIN

	 
 
		   RAISERROR('BUSINESS MODULE DOES NOT EXIST',16,1)

		END 
		END 
	ELSE 
		BEGIN

		-- LOB DOES NOT EXIST

		   -- Throw exception 
	 

		   RAISERROR('LOB DOES NOT EXIST',16,1)

		END 
END
	 else
begin 
select * from #temp 
	 
END
 
IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL 
drop table #temp
END











 
/****** Object:  StoredProcedure [dbo].[spGetAllTeamMembersByTeamByUUID]    Script Date: 4/25/2017 11:51:39 AM ******/
SET ANSI_NULLS ON



