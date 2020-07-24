-- =============================================
-- Author:		Greeshma
-- Create date: 03-12-2018
-- Description:	Procedure for handling BusinessProcessInfoes data insertions
-- =============================================
CREATE Procedure [dbo].[spInsert_Mapping_BusinessProcessInfoes]
	@P_BusinessProcessCode nvarchar(100),
	@P_SubscribedDate datetime=NULL,
	@P_AccountCode nvarchar(50),
	@P_BusinessProcessID int out
AS
BEGIN

	SET NOCOUNT ON;

	declare @AccountID int, @BusinessProcessID int;

	
	(select @AccountID=AccountInfoID from AccountInfoes where AccountCode=@P_AccountCode)
	
	if(@AccountID is not null )
	begin
	If not exists(select 1 from [BusinessProcessInfoes]
	where ISNULL([BusinessProcessCode],'12311231') = ISNULL(@P_BusinessProcessCode,'12311231') and ISNULL([AccountID],'12311231')=@AccountID)
	BEGIN
	  insert into [BusinessProcessInfoes] 
	  ([BusinessProcessCode],  [AccountID], [CreatedBy], [CreatedDate],SubscribedDate)
	  values(@P_BusinessProcessCode,  @AccountID, 'AMTeam', getdate(),GETDATE()) ;

	  select @P_BusinessProcessID= scope_identity();
	  
	END
	else
	begin

	select @P_BusinessProcessID=[BusinessProcessInfoID] from [BusinessProcessInfoes]
	where ISNULL([BusinessProcessCode],'12311231') = ISNULL(@P_BusinessProcessCode,'12311231') and ISNULL([AccountID],'12311231')=@AccountID

	end;

	end;
	select  @P_BusinessProcessID;
	
END








