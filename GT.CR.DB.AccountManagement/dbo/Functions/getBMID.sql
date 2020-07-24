
Create Function [dbo].[getBMID](@AccName varchar(50),@modulename varchar(50))
returns int as
begin
declare @bmid int

select top 1 @bmid=bmi.businessmoduleinfoid from BusinessModuleInfoes bmi
join accountinfoes ac on ac.AccountName=@AccName  and ac.Category='LOB'
join [BusinessProcessInfoes] bpi on bpi.[BusinessProcessInfoID]=bmi.[BusinessProcessInfoID] and bpi.AccountID=ac.AccountInfoID
join businessmodules bm on bm.businessmodulecode=bmi.businessmodulecode and bm.BusinessModuleName=@modulename  

return @bmid
end 

