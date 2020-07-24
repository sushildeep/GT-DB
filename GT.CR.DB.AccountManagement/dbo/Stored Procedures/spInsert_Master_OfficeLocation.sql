-- =============================================
-- Author:		Greeshma
-- Create date: 17-12-2016
-- Description:	Procedure for adding office Location master Data 
-- =============================================
CREATE Procedure [dbo].[spInsert_Master_OfficeLocation]
	@P_OfficeLocationName nvarchar(250),
--	@P_OfficeLocationCode nvarchar(50)=null,
	@P_AccountCode nvarchar(50),
	@P_OfficeLocationDescription nvarchar(max)=null
AS
BEGIN

	SET NOCOUNT ON;

	declare @AccountID int , @AccAbbrev nvarchar(10), @LocationCode varchar(50);
		declare @OfficeLocationID int ,
			@Max_Code int,
			@Char_Code varchar(50),
			@Unique_Code varchar(50),
			@LocID int;
	

	if(ltrim(rtrim(@P_OfficeLocationName))!='')

	begin
				select @AccountID=AccountInfoID,@AccAbbrev= AccountAbbreviation  from AccountInfoes where AccountCode=@P_AccountCode;

				if not exists (select 1 from [dbo].[OfficeLocation] where AccountInfoID=@AccountID and OfficeLocationName=ltrim(rtrim(@P_OfficeLocationName)))
				begin
				
						--- UNIQUE CODE GENERATION


				      select @Max_Code=max(replace(OfficeLocationCode,@AccAbbrev,'')) from [OfficeLocation] where OfficeLocationCode like '%'+@AccAbbrev+'%';
					    if(@Max_Code is null)
					    set @Max_Code=1
					  else                      
				     set @Max_Code=@Max_Code+1
				            
				     set @Char_Code=cast(@Max_Code  as nvarchar(50))                                                  
				     set @Unique_Code=concat(@AccAbbrev,convert(varchar,REPLICATE('0',7 - len(@Char_Code))) ,@Char_Code)
				     set @LocationCode=@Unique_Code;   

					 --==================================================
				
				
					insert into [dbo].[OfficeLocation]
					( [AccountInfoID], [OfficeLocationName], [OfficeLocationCode], [Description], [Status], [CreatedBy], [CreatedDate])
					select @AccountID,@P_OfficeLocationName, @LocationCode , @P_OfficeLocationDescription ,'Active','AMTeam',getdate()


				end
				else
				begin 

					select @LocID=OfficeLocationID,@LocationCode=OfficeLocationCode  from [OfficeLocation] where AccountInfoID=@AccountID and OfficeLocationName=ltrim(rtrim(@P_OfficeLocationName))

					update  [dbo].[OfficeLocation]
					set Status='Active'
					where OfficeLocationID=@LocID;



				end 

		end
	select @LocationCode;
end



--exec [dbo].[spInsert_Master_OfficeLocation]
--	@P_OfficeLocationName ='NBCX',

--	@P_AccountCode='LOB000002'


	--select * from AccountInfoes
	--select * from OfficeLocation
	--insert into OfficeLocation
	--( [AccountInfoID], [OfficeLocationName], [OfficeLocationCode], [Description], [Status], [CreatedBy], [CreatedDate])
	--values (4,'NBC','HFS0000002',null,'Active','AMTeam',getdate())

	--dbcc checkident('OfficeLocation',reseed,4)

	--delete from OfficeLocation where OfficeLocationID=10004
