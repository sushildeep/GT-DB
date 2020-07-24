-- =============================================
-- Author:		Abhinav Yadav
-- ALTER date: 19/12/2016
-- Description:	Returns list of users who are subordinate of a specific user forn an account and business process
-- =============================================
CREATE Procedure [dbo].[spGetAllSubOrdinatesByUser]

	 @uuid varchar(max)
	,@businessModuleCode varchar(max)
	,@accountCode varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	  SELECT distinct
		  usrs.[UUID]
		 ,usrs.[First_Name]
		 ,usrs.[Last_Name]
		 ,usrs.[Middle_Name]
		-- ,usrs.[Email]
	 FROM [TeamMappings] tmmap 
	 JOIN Users usrs 
	 ON tmmap.UUID=usrs.UUID 
	 AND tmmap.[TeamID] in
	 (
	  SELECT tm.TeamID
	  FROM [dbo].[TeamMappings] tmap
	  INNER JOIN [dbo].[Teams] tm
		ON tmap.TeamID=tm.TeamID
	  INNER JOIN [dbo].[Departments] dpt
		ON tm.[DepartmentID]=dpt.[DepartmentID]
	  INNER JOIN [dbo].[BusinessModuleInfoes] bmi
		ON dpt.[BusinessModuleInfoID]=bmi.[BusinessModuleInfoID]
	  WHERE tmap.UUID=@uuid--'UU0000512'
	  AND tmap.AccountCode=@accountCode--'AC0000002'
	  AND tmap.ParentOrChildID=0
	  AND bmi.[BusinessModuleCode]=@businessModuleCode--'BM0000002'
	 )
	-- AND tmmap.[ParentOrChildID]=1
END

 


 --[spGetAllSubOrdinatesByUser] 'UU0000512','BM0000002','LOB000001'





