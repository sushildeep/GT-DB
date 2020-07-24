-- =============================================
-- Author:		Balaji & Sudhakar
-- Create date: 03-12-2016
-- Description:	Procedure for handling WorkGroups data insertions
-- =============================================
CREATE Procedure [dbo].[spInsertWorkGroups]
	@P_WorkGroupName nvarchar(100)=NULL,
	@P_WorkGroupCode nvarchar(100)=NULL,
	@P_WorkGroupType nvarchar(100)=NULL,
	@P_BusinessModuleInfoID bigint=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL,
	@P_WorkGroupID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;
	
	select @P_WorkGroupID = min([WorkGroupID]) from [WorkGroups]
	where ISNULL([WorkGroupName],'12311231') = ISNULL(@P_WorkGroupName,'12311231') and ISNULL([WorkGroupCode],'12311231') = ISNULL(@P_WorkGroupCode,'12311231') and ISNULL([WorkGroupType],'12311231') = ISNULL(@P_WorkGroupType,'12311231') and ISNULL([BusinessModuleInfoID],'12311231') = ISNULL(@P_BusinessModuleInfoID,'12311231') and ISNULL([CreatedBy],'12311231') = ISNULL(@P_CreatedBy,'12311231') and ISNULL([CreatedDate],'12311231') = ISNULL(@P_CreatedDate,'12311231') and ISNULL([UpdatedBy],'12311231') = ISNULL(@P_UpdatedBy,'12311231') and ISNULL([LastModifiedDate],'12311231') = ISNULL(@P_LastModifiedDate,'12311231')

	If(@P_WorkGroupID is null)
	BEGIN
	  insert into [WorkGroups] ([WorkGroupName], [WorkGroupCode], [WorkGroupType], [BusinessModuleInfoID], [CreatedBy], [CreatedDate], [UpdatedBy], [LastModifiedDate])
	  values(@P_WorkGroupName, @P_WorkGroupCode, @P_WorkGroupType, @P_BusinessModuleInfoID, @P_CreatedBy, @P_CreatedDate, @P_UpdatedBy, @P_LastModifiedDate) ;
	  SET @P_WorkGroupID = SCOPE_IDENTITY();
	END


	RETURN 1
END








