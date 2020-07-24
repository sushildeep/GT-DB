
 --Create function to get BusinessModuleInfoID
CREATE function [dbo].[getBusinessModuleInfoID]
(
 @AccountCode varchar(15),
 @ModuleCode varchar(15)
)
returns int
As
Begin 
 declare @BusinessModuleInfoID int

set @BusinessModuleInfoID= (select BusinessModuleInfoID from BusinessModuleInfoes
where BusinessProcessInfoID in (select BusinessProcessInfoID
from BusinessProcessInfoes where AccountID=(select AccountInfoID from AccountInfoes 
where AccountCode=@AccountCode)) and BusinessModuleCode=@ModuleCode)
  
 
 return @BusinessModuleInfoID;


end 
