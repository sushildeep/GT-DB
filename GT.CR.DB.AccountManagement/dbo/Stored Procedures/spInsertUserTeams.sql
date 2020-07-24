-- =============================================
-- Author:		Balaji & Sudhakar
-- Create date: 03-12-2016
-- Description:	Procedure for handling UserTeams data insertions
-- =============================================
CREATE Procedure [dbo].[spInsertUserTeams]
	@P_AccountCode nvarchar(100)=NULL,
	@P_BusinessProcessInfoID bigint=NULL,
	@P_BusinessModuleInfoID bigint=NULL,
	@P_DepartmentCode nvarchar(100)=NULL,
	@P_TeamID bigint=NULL,
	@P_UserID nvarchar(100)=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL,
	@P_UserTeamID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;
	
	select @P_UserTeamID = min([UserTeamID]) from [UserTeams]
	where ISNULL([AccountCode],'12311231') = ISNULL(@P_AccountCode,'12311231') and ISNULL([BusinessProcessInfoID],'12311231') = ISNULL(@P_BusinessProcessInfoID,'12311231') and ISNULL([BusinessModuleInfoID],'12311231') = ISNULL(@P_BusinessModuleInfoID,'12311231') and ISNULL([DepartmentCode],'12311231') = ISNULL(@P_DepartmentCode,'12311231') and ISNULL([TeamID],'12311231') = ISNULL(@P_TeamID,'12311231') and ISNULL([UserID],'12311231') = ISNULL(@P_UserID,'12311231') and ISNULL([CreatedBy],'12311231') = ISNULL(@P_CreatedBy,'12311231') and ISNULL([CreatedDate],'12311231') = ISNULL(@P_CreatedDate,'12311231') and ISNULL([UpdatedBy],'12311231') = ISNULL(@P_UpdatedBy,'12311231') and ISNULL([LastModifiedDate],'12311231') = ISNULL(@P_LastModifiedDate,'12311231')

	If(@P_UserTeamID is null)
	BEGIN
	  insert into [UserTeams] ([AccountCode], [BusinessProcessInfoID], [BusinessModuleInfoID], [DepartmentCode], [TeamID], [UserID], [CreatedBy], [CreatedDate], [UpdatedBy], [LastModifiedDate])
	  values(@P_AccountCode, @P_BusinessProcessInfoID, @P_BusinessModuleInfoID, @P_DepartmentCode, @P_TeamID, @P_UserID, @P_CreatedBy, @P_CreatedDate, @P_UpdatedBy, @P_LastModifiedDate) ;
	  SET @P_UserTeamID = SCOPE_IDENTITY();
	END


	RETURN 1
END








