-- =============================================
-- Author:		Balaji & Sudhakar
-- Create date: 03-12-2016
-- Description:	Procedure for handling OfficeLocations data insertions
-- =============================================
CREATE Procedure [dbo].[spInsertOfficeLocations]
	@P_AddressLine1 nvarchar(100)=NULL,
	@P_AddressLine2 nvarchar(100)=NULL,
	@P_City nvarchar(100)=NULL,
	@P_State nvarchar(100)=NULL,
	@P_ZipCode nvarchar(100)=NULL,
	@P_County nvarchar(100)=NULL,
	@P_Country nvarchar(100)=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL,
	@P_Department_DepartmentID bigint=NULL,
	@P_AddressID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;
	
	select @P_AddressID = min([AddressID]) from [OfficeLocations]
	where ISNULL([AddressLine1],'12311231') = ISNULL(@P_AddressLine1,'12311231') and ISNULL([AddressLine2],'12311231') = ISNULL(@P_AddressLine2,'12311231') and ISNULL([City],'12311231') = ISNULL(@P_City,'12311231') and ISNULL([State],'12311231') = ISNULL(@P_State,'12311231') and ISNULL([ZipCode],'12311231') = ISNULL(@P_ZipCode,'12311231') and ISNULL([County],'12311231') = ISNULL(@P_County,'12311231') and ISNULL([Country],'12311231') = ISNULL(@P_Country,'12311231') and ISNULL([CreatedBy],'12311231') = ISNULL(@P_CreatedBy,'12311231') and ISNULL([CreatedDate],'12311231') = ISNULL(@P_CreatedDate,'12311231') and ISNULL([UpdatedBy],'12311231') = ISNULL(@P_UpdatedBy,'12311231') and ISNULL([LastModifiedDate],'12311231') = ISNULL(@P_LastModifiedDate,'12311231') and ISNULL([Department_DepartmentID],'12311231') = ISNULL(@P_Department_DepartmentID,'12311231')

	If(@P_AddressID is null)
	BEGIN
	  insert into [OfficeLocations] ([AddressLine1], [AddressLine2], [City], [State], [ZipCode], [County], [Country], [CreatedBy], [CreatedDate], [UpdatedBy], [LastModifiedDate], [Department_DepartmentID])
	  values(@P_AddressLine1, @P_AddressLine2, @P_City, @P_State, @P_ZipCode, @P_County, @P_Country, @P_CreatedBy, @P_CreatedDate, @P_UpdatedBy, @P_LastModifiedDate, @P_Department_DepartmentID) ;
	  SET @P_AddressID = SCOPE_IDENTITY();
	END


	RETURN 1
END








