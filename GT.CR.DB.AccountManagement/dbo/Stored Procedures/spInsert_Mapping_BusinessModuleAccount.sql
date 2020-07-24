-- =============================================
-- Author:		Greeshma
-- Create date: 14-12-2016
-- Description:	Procedure for handling BusinessModuleInfoes data insertions
-- =============================================
CREATE Procedure [dbo].[spInsert_Mapping_BusinessModuleAccount]
	@P_BusinessModuleCode nvarchar(100),
	@P_AccountCode nvarchar(100)
	AS
BEGIN

	SET NOCOUNT ON;

	declare @AccountID int , @BusinessModuleInfoID int,@Module varchar(100),@Account varchar(100),@ModURLKey varchar(100);
	declare @BusinessProcessInfoID int,@BusinessProcessCode varchar(50);

	select @BusinessProcessCode=BusinessProcessCode from BusinessProcesses where businessProcessID in
	(select BusinessProcessID from BusinessModules where BusinessModuleCode=@P_BusinessModuleCode);
	
	if( @BusinessProcessCode is not  null )
	begin
			exec [dbo].[spInsert_Mapping_BusinessProcessInfoes]
			@P_BusinessProcessCode =@BusinessProcessCode,			
			@P_AccountCode=@P_AccountCode,
			@P_BusinessProcessID=@BusinessProcessInfoID out;


	--select [BusinessProcessInfoID] from [dbo].[BusinessProcessInfoes] bpi
	--join [dbo].[AccountInfoes] a on a.[AccountInfoID]=bpi.[AccountID] and a.[AccountCode] =@P_AccountCode
	--where [BusinessProcessCode] in (
	--select [BusinessProcessCode] from [dbo].[BusinessProcesses] 
	--where [BusinessProcessID] in ( select [BusinessProcessID] from [dbo].[BusinessModules] where [BusinessModuleCode] =@P_BusinessModuleCode))
	

	if(@BusinessProcessInfoID is not null)
	begin 
		If not exists (select 1 from  [BusinessModuleInfoes] where [BusinessModuleCode]= @P_BusinessModuleCode
		and [BusinessProcessInfoID] =@BusinessProcessInfoID
		)
		begin
		
		select @Module =[BusinessModuleName] from [dbo].[BusinessModules] where [BusinessModuleCode] =@P_BusinessModuleCode
		select @Account=[AccountName] from [dbo].[AccountInfoes] where [AccountCode] =@P_AccountCode;
		set @ModURLKey= UPPER(replace(@Account,' ','')+replace(@Module,' ',''));
			
			insert into  [BusinessModuleInfoes]
			(  [BusinessProcessInfoID], [CreatedBy], [CreatedDate], [BusinessModuleCode], [ModuleURLKey])
			select @BusinessProcessInfoID,'AM Team',getdate(),@P_BusinessModuleCode,@ModURLKey ;

		end	
	end 
	else
	begin
			print 'Account does not exists.'
	end

end
else
begin
		print 'Business Module  does not exists.'
end

END







