-- =============================================
-- Author:		Mahesh
-- Create date: 14-12-2018
-- Description:	Procedure for Insert Master Departments 
-- =============================================
-- [spInsert_Master_Departments] 'TestDPT',null,null,'LOB000001','BM0000001'
CREATE Procedure [dbo].[spInsert_Master_Departments]
	@DeptName nvarchar(100), 
	@DeptEmail nvarchar(150)=NULL, 
	@Abbreviation nvarchar(50), 
	@AccountCode nvarchar(15), 
	@ModuleCode nvarchar(15)

AS
BEGIN

	SET NOCOUNT ON;
	
	declare @DeptCode nvarchar(15) 
	declare @getBusinessModuleInfoID int
	declare @AccountID int

	set @getBusinessModuleInfoID=(select [dbo].[getBusinessModuleInfoID](@AccountCode,@ModuleCode))
	set @AccountID=(select AccountInfoID from AccountInfoes where AccountCode=@AccountCode)

	if not exists(select 1 from Departments where [Name]=@DeptName and BusinessModuleInfoID=@getBusinessModuleInfoID)
		begin
			exec [spGenerateUniqueCode] @prefix='DD', @TableName='Departments', @ColumnName='DepartmentCode', @UniqueCode=@DeptCode output
	 
			insert into Departments ([DepartmentCode], [Email], [Name], [BusinessModuleInfoID], [CreatedBy], [CreatedDate], [AccountInfoID], [Abbreviation])
			select @DeptCode, @DeptEmail, @DeptName, @getBusinessModuleInfoID, 'AMTeam', getdate(),@AccountID, @Abbreviation

			select @DeptCode
		end

	else
		begin
			--select 'Department is already Exist'
			select @DeptCode
		end

	END









