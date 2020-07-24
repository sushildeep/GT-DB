-- =============================================
-- Author:		Balaji & Sudhakar
-- Create date: 03-12-2016
-- Description:	Procedure for handling TeamMappings data insertions
-- =============================================
CREATE Procedure [dbo].[spInsertTeamMappings]
	@P_TeamID bigint=NULL,
	@P_UserID nvarchar(100)=NULL,
	@P_AccountCode nvarchar(100)=NULL,
	@P_TeamNodeType nvarchar(100)=NULL,
	@P_ParentOrChildID int=NULL,
	@P_Status nvarchar(100)=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL,
	@P_TeamMappingID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;
	
	select @P_TeamMappingID = min([TeamMappingID]) from [TeamMappings]
	where ISNULL([TeamID],'12311231') = ISNULL(@P_TeamID,'12311231') and ISNULL([UUID],'12311231') = ISNULL(@P_UserID,'12311231') and ISNULL([AccountCode],'12311231') = ISNULL(@P_AccountCode,'12311231') and ISNULL([TeamNodeType],'12311231') = ISNULL(@P_TeamNodeType,'12311231') and ISNULL([ParentOrChildID],'12311231') = ISNULL(@P_ParentOrChildID,'12311231') and ISNULL([Status],'12311231') = ISNULL(@P_Status,'12311231') and ISNULL([CreatedBy],'12311231') = ISNULL(@P_CreatedBy,'12311231') and ISNULL([CreatedDate],'12311231') = ISNULL(@P_CreatedDate,'12311231') and ISNULL([UpdatedBy],'12311231') = ISNULL(@P_UpdatedBy,'12311231') and ISNULL([LastModifiedDate],'12311231') = ISNULL(@P_LastModifiedDate,'12311231')

	If(@P_TeamMappingID is null)
	BEGIN
	  insert into [TeamMappings] ([TeamID], [UUID], [AccountCode], [TeamNodeType], [ParentOrChildID], [Status], [CreatedBy], [CreatedDate], [UpdatedBy], [LastModifiedDate])
	  values(@P_TeamID, @P_UserID, @P_AccountCode, @P_TeamNodeType, @P_ParentOrChildID, @P_Status, @P_CreatedBy, @P_CreatedDate, @P_UpdatedBy, @P_LastModifiedDate) ;
	  SET @P_TeamMappingID = SCOPE_IDENTITY();
	END


	RETURN 1
END






