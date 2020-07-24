-- =============================================
-- Author:		Mahesh
-- Create date: 14-12-2018
-- Description:	Procedure to Add Master Teams
-- =============================================
--exec [spInsert_Master_Teams] '',null,'DD0000003'
CREATE Procedure [dbo].[spInsert_Master_Teams]	
	@TeamName nvarchar(150),
	@TeamEmail nvarchar(150)=NULL,
	@DepartmentCode nvarchar(15)

AS
BEGIN

	SET NOCOUNT ON;
	declare @TeamCode nvarchar(15) 
	declare @DepartmentID int

	set @DepartmentID=(select DepartmentID from Departments where DepartmentCode=@DepartmentCode)
	
	if not exists (select 1 from teams where Name=@TeamName and DepartmentID=@DepartmentID)
	begin
	exec [spGenerateUniqueCode] @prefix='TM', @TableName='Teams', @ColumnName='TeamCode', @UniqueCode=@TeamCode output
	
	select @TeamCode
	insert into Teams([TeamCode], [Name], [Email], [DepartmentID], [CreatedBy], [CreatedDate])
	select @TeamCode,@TeamName,@TeamEmail,@DepartmentID,'AMTeam',getdate()
		
	end

	else
	begin
	select @TeamCode
	end	

END
SET ANSI_NULLS ON








