-- =============================================
-- Author:		Greeshma
-- Create date: 03--2016
-- Description:	Procedure for handling BusinessProcesses data insertions
-- =============================================
CREATE Procedure [dbo].[spInsert_Master_BusinessProcessesandModule]
	@P_BusinessProcessName nvarchar(100),
	@P_BusinessModuleName nvarchar(100)	,
	@P_BUsinessModuleLogoPath nvarchar(max)=null
AS
BEGIN

	SET NOCOUNT ON;

	if(ltrim(rtrim(@P_BusinessProcessName)) !='')
	begin
			--select *  from [BusinessProcesses]

			--- Adding Business Process Master data-----------

			declare @BusinessProcessCode varchar(50),@BUsinessMOduleCode varchar(50);
			
			if not exists(select [BusinessProcessID] from [BusinessProcesses]
			where  ISNULL([BusinessProcessName],'12311231') = ISNULL(@P_BusinessProcessName,'12311231') )
			begin

			exec [dbo].[spGenerateUniqueCode] @prefix ='BP', @TableName ='BusinessProcesses', @ColumnName ='BusinessProcessCode',@UniqueCode=@BusinessProcessCode out;
			
			  insert into [BusinessProcesses] ([BusinessProcessCode], [BusinessProcessName], [CreatedBy], [CreatedDate])
			  values(@BusinessProcessCode, @P_BusinessProcessName, 'AMTeam', getdate()) ;
			  select @BusinessProcessCode;
			  
			END
			else
			begin
				
				select @BusinessProcessCode=[BusinessProcessCode] from [BusinessProcesses]
				where  ISNULL([BusinessProcessName],'12311231') = ISNULL(@P_BusinessProcessName,'12311231')  		 

			end

			---- Adding Business MOdule  ---------------

			if( ltrim(rtrim(@P_BusinessModuleName))!='')
			begin
				exec [dbo].[spInsert_Master_BusinessModules]	@P_BusinessModuleName =@P_BusinessModuleName,@P_LogoPath=@P_BUsinessModuleLogoPath, @P_BusinessProcessCode =@BusinessProcessCode,@P_BusinessModuleCode=@BUsinessMOduleCode out;
			end

	end

	select @BusinessProcessCode BUsinessProcessModuleCode, @BUsinessMOduleCode BusinessModuleCode ;

END








