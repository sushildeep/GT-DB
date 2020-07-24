-- =============================================
-- Author:		Greeshma
-- Create date: 17-12-2016
-- Description:	Procedure for adding Area , SubArea master Data 
-- =============================================
CREATE Procedure [dbo].[spInsert_Master_Area_SubArea]
	@P_AreaName nvarchar(100),
	@P_AreaDesciption nvarchar(max)=null,
	@P_SubAreaName nvarchar(100),
	@P_SubAreaDescription nvarchar(max)=null,
	@P_OfficeLocationCode nvarchar(100)
	AS
BEGIN

	SET NOCOUNT ON;

	declare @OfficeLocationID int ,
			@Max_Code int,
			@Char_Code varchar(50),
			@Unique_Code varchar(50),
			@AreaCode varchar(50),
			@SubAreaCode varchar(50),
			@LocAreaID int,
			@SubAreaID int;

	select @OfficeLocationID= OfficeLocationID from [dbo].[OfficeLocation] where OfficeLocationCode=@P_OfficeLocationCode;

	--============================================ ADDING AREA MASTER DATA  ==========================================================================
	if(ltrim(@P_AreaName)!='')
	begin
				if(  @OfficeLocationID is not null and not exists(select 1 from [dbo].[LocationArea] where OfficeLocationID=@OfficeLocationID and AreaName=ltrim(rtrim(@P_AreaName))))
				begin


					----- Generating Unique LOB Code
				    select @Max_Code=max(replace([AreaCode],@P_OfficeLocationCode+'_','')) from [LocationArea] where [AreaCode] like '%'+@P_OfficeLocationCode+'%';
				    if(@Max_Code is null)
				      set @Max_Code=1
				    else                      
				     set @Max_Code=@Max_Code+1
				            
				     set @Char_Code=cast(@Max_Code  as nvarchar(50))                                                  
				     set @Unique_Code=concat(@P_OfficeLocationCode+'_',convert(varchar,REPLICATE('0',2 - len(@Char_Code))) ,@Char_Code)
				     set @AreaCode=@Unique_Code;   

				     --================================================================================================


					insert into [dbo].[LocationArea]
					( [OfficeLocationID], [AreaCode], [AreaName], [Description], [Status], [CreatedBy], [CreatedDate])
					select @OfficeLocationID,@AreaCode,ltrim(rtrim(@P_AreaName)),@P_AreaDesciption,'Active','AMTeam',getdate();

					select @LocAreaID=SCOPE_IDENTITY();
				end
				else
				begin 

					select @LocAreaID=[LocationAreaID],@AreaCode=AreaCode from [dbo].[LocationArea] where OfficeLocationID=@OfficeLocationID and AreaName=@P_AreaName

					update  [dbo].[LocationArea]
					set Status='Active'
					where [LocationAreaID]=@LocAreaID;



				end 
				----=================================== ADDING SUB AREA MASTER DATA  ===================================================================
				if(@P_SubAreaName is null or ltrim(@P_SubAreaName)='')
				set @P_SubAreaName=@P_AreaName;

				if(  @LocAreaID is not null and not exists(select 1 from [dbo].[SubAreaInfo] where LocationAreaID=@LocAreaID and SubAreaName=ltrim(rtrim(@P_SubAreaName))))
				begin


					----- Generating Unique LOB Code
				    select @Max_Code=max(replace(SubAreaCode,@P_OfficeLocationCode+'_SA','')) from [SubAreaInfo] where SubAreaCode like '%'+@P_OfficeLocationCode+'%';
				    if(@Max_Code is null)
				      set @Max_Code=1
				    else                      
				     set @Max_Code=@Max_Code+1
				            
				     set @Char_Code=cast(@Max_Code  as nvarchar(50))                                                  
				     set @Unique_Code=concat(@P_OfficeLocationCode+'_SA',convert(varchar,REPLICATE('0',3 - len(@Char_Code))) ,@Char_Code)
				     set @SubAreaCode=@Unique_Code;   

				     --================================================================================================


					insert into [dbo].[SubAreaInfo]
					( [LocationAreaID], [SubAreaCode], [SubAreaName], [Description], [Status], [CreatedBy], [CreatedDate])
					select @LocAreaID,@SubAreaCode,ltrim(rtrim(@P_SubAreaName)),@P_SubAreaDescription,'Active','AMTeam',getdate();

					select @SubAreaID=SCOPE_IDENTITY();
				end
				else
				begin 

					select @SubAreaID=SubAreaInfoID from [dbo].[SubAreaInfo] where LocationAreaID=@LocAreaID and SubAreaName=ltrim(rtrim(@P_SubAreaName))

					update  [dbo].[SubAreaInfo]
					set Status='Active'
					where SubAreaInfoID=@SubAreaID;

				end 


				select @AreaCode AreaCode , @SubAreaCode SubAreaCode;

	end
	--select * from  [dbo].[SubAreaInfo] where SubAreaInfoID=53
	--select * from [dbo].[LocationArea]


	--dbcc checkident('[SubAreaInfo]',reseed,52)

	--exec [dbo].[spInsert_Master_Area_SubArea]
	--@P_AreaName ='Housekeeping',
	--@P_SubAreaName ='Pantry',
	--@P_OfficeLocationCode ='HFS0000002'
	
END







