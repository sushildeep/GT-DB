
 --Create function to get BusinessModuleInfoID
CREATE function [dbo].[getBusinessModuleInfoIDByName]
(
 @AccountName varchar(max),
 @ModuleName varchar(max)
)
returns int
As
Begin 
 declare @BusinessModuleInfoID int=0

set @BusinessModuleInfoID= (select BusinessModuleInfoID from [dbo].[BusinessModuleInfoes]
					where BusinessProcessInfoID=(select BusinessProcessInfoID from BusinessProcessInfoes
			where AccountID=(select accountinfoid from AccountInfoes where AccountName=@AccountName and Category='LOB'))
			and BusinessModuleCode=(select BusinessModuleCode from businessmodules where BusinessModuleName=@ModuleName))
  
 
 return @BusinessModuleInfoID;


end