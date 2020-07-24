-- =============================================
-- Author:		Balaji & Sudhakar
-- Create date: 03-12-2016
-- Description:	Procedure for handling Privileges data insertions
-- =============================================
CREATE Procedure [dbo].[spInsertPrivileges]
	
	@P_PrivilegeName nvarchar(100)=NULL,
	
	@P_BusinessModuleID bigint=NULL,
	@P_CreatedBy nvarchar(100)=NULL,
	@P_CreatedDate datetime=NULL,
	@P_UpdatedBy nvarchar(100)=NULL,
	@P_LastModifiedDate datetime=NULL,
	@P_PrivilegeID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @P_PrivilegeCode varchar(100);
	DECLARE @Max_ID int;
	select @P_PrivilegeID = min([PrivilegeID]) from [Privileges]
	where ISNULL([PrivilegeName],'12311231') = ISNULL(@P_PrivilegeName,'12311231') 
	and ISNULL([BusinessModuleID],'12311231') = ISNULL(@P_BusinessModuleID,'12311231') 
	

	If(@P_PrivilegeID is null)
	BEGIN
				
		select @Max_ID=max(convert(int, replace(PrivilegeCode,'PR',''))) from [Privileges]

	    if(@Max_ID is null)
		begin
			set @Max_ID=1
		end
	    else 
		begin
			set @Max_ID=@Max_ID+1;
		end

	    set @P_PrivilegeCode='PR' +REPLICATE('0', 7 - LEN(convert(varchar, @Max_ID))) + convert(varchar, @Max_ID)

		
	 insert into [Privileges] ([PrivilegeCode], [PrivilegeName], 
	   [BusinessModuleID], 
	  [CreatedBy], [CreatedDate], 
	  [UpdatedBy], [LastModifiedDate])
	  values(@P_PrivilegeCode, @P_PrivilegeName, 
	   @P_BusinessModuleID, 
	  @P_CreatedBy, @P_CreatedDate, 
	  @P_UpdatedBy, @P_LastModifiedDate) ;
	  SET @P_PrivilegeID = SCOPE_IDENTITY();
	END


	RETURN 1
END








