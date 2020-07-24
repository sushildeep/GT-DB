--exec [spGetUserAllLowerLevelTeamHierarchy] @AccountCode='LOB000001',@BusinessModuleCode='BM0000001',@TeamName='SAVE',@UUID='UU0000007',@TeamLevels=2  --, @OfficeLocationCode='MCD0000001'

CREATE Procedure [dbo].[spGetUserAllLowerLevelTeamHierarchy] @AccountCode nvarchar(15), @BusinessModuleCode nvarchar(15), 
@OfficeLocationCode nvarchar(15)=null, @TeamName nvarchar(max), @UUID nvarchar(15),@TeamLevels int=0
as 
begin
	
	declare @Rows int=0;
	  
    select distinct ltm.UUID  into #out
	from UserTeamMapping ltm 	
	join users on users.UUID=ltm.ParentOrChildID
	join UserAccountMappings uam on uam.UserID=users.UserID and uam.OfficeLocationID=ltm.OfficeLocationID
	join OfficeLocation ol on ol.OfficeLocationID=ltm.OfficeLocationID and  uam.OfficeLocationID=ol.OfficeLocationID	
	join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID
	join teams on teams.TeamID=ltm.TeamID
	where ltm.ParentOrChildID=@UUID and ltm.AccountCode=@AccountCode 
	and bmi.BusinessModuleCode=@BusinessModuleCode --and ol.OfficeLocationCode=isnull(@OfficeLocationCode,ol.OfficeLocationCode)
	and teams.[Name]=@TeamName

	SELECT @Rows=@@ROWCOUNT;
	if(@TeamLevels is null) set @TeamLevels=0
	if(@TeamLevels!=1)
	begin
	while (@Rows!=0 and (@TeamLevels>=0))
	begin 
	
			print '1st RCount '+convert(nvarchar,@Rows);
			set @Rows=0;

			insert into #Out
			select distinct ltm.UUID  
			from UserTeamMapping ltm 	
			join users on users.UUID=ltm.ParentOrChildID
			join UserAccountMappings uam on uam.UserID=users.UserID and uam.OfficeLocationID=ltm.OfficeLocationID
			join OfficeLocation ol on ol.OfficeLocationID=ltm.OfficeLocationID and  uam.OfficeLocationID=ol.OfficeLocationID	
			join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID
			join teams on teams.TeamID=ltm.TeamID
			where ltm.ParentOrChildID in (select * from #Out) and ltm.UUID not in (select * from #Out)
			 and ltm.AccountCode=@AccountCode 
			and bmi.BusinessModuleCode=@BusinessModuleCode --and ol.OfficeLocationCode=isnull(@OfficeLocationCode,ol.OfficeLocationCode)
			and teams.[Name]=@TeamName 
			

			SELECT @Rows=@@ROWCOUNT;
			print '2nd RCount '+convert(nvarchar,@Rows);
			set @TeamLevels=@TeamLevels-1;
	end
	end

	select distinct * from #out
	drop table #out

end


