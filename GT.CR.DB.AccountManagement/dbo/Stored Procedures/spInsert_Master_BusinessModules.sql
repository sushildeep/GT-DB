-- =============================================
-- Author:		Greeshma
-- Create date: 14-12-2018
-- Description:	Procedure for handling BusinessModules data insertions
-- =============================================
CREATE Procedure [dbo].[spInsert_Master_BusinessModules]
	@P_BusinessModuleName nvarchar(100)=NULL,	
	@P_LogoPath nvarchar(500)=NULL,
	@P_BusinessProcessCode nvarchar(100),
	@P_BusinessModuleCode nvarchar(50) out
	
	
AS
BEGIN

	SET NOCOUNT ON;
	
	declare @BusinessProcessID int,@BusinessModuleCode nvarchar(100);

	(select @BusinessProcessID=[BusinessProcessID] from [dbo].[BusinessProcesses] where [BusinessProcessCode]=@P_BusinessProcessCode)

	if(@BusinessProcessID is not null)
	begin
		if not exists(select 1 from [BusinessModules]
		where [BusinessModuleName] = ISNULL(@P_BusinessModuleName,'12311231') and 
		[BusinessProcessID] =@BusinessProcessID) 
		begin

			exec [dbo].[spGenerateUniqueCode] @prefix ='BM', @TableName ='BusinessModules', @ColumnName ='BusinessModuleCode',@UniqueCode=@BusinessModuleCode out;
		

		  insert into [BusinessModules] ([BusinessModuleName], [BusinessModuleCode], [BusinessProcessID], [CreatedBy], [CreatedDate],LogoPath)
		  values(@P_BusinessModuleName, @BusinessModuleCode, @BusinessProcessID, 'AMTeam', getdate(),@P_LogoPath) ;
		end

	  
	  
	END
	else 
	begin

		select @BusinessModuleCode=[BusinessModuleCode] from [BusinessModules]
		where [BusinessModuleName] = ISNULL(@P_BusinessModuleName,'12311231') and 
		[BusinessProcessID] =@BusinessProcessID;

	end 
	set @P_BusinessModuleCode=@BusinessModuleCode;


	select @BusinessModuleCode;
END








