--exec [spGetUserAllHigherLevelTeamHierarchy] @AccountCode='LOB000001',@BusinessModuleCode='BM0000001',@TeamName='SAVE',@UUID='UU0000006',@TeamLevels=null, @OfficeLocationCode='MCD0000001'

CREATE Procedure [dbo].[spGetUserAllHigherLevelTeamHierarchy] @AccountCode nvarchar(15),@BusinessModuleCode nvarchar(15), 
@OfficeLocationCode nvarchar(15)=null,@TeamName nvarchar(max),@UUID nvarchar(15),@TeamLevels int=0
as 
begin

	declare @Rows int=0;
	
    select distinct ltm.ParentOrChildID     into #ParentUUIDs
	from UserTeamMapping ltm 	
	join users on users.UUID=ltm.UUID
	join UserAccountMappings uam on uam.UserID=users.UserID and uam.OfficeLocationID=ltm.OfficeLocationID
	join OfficeLocation ol on ol.OfficeLocationID=ltm.OfficeLocationID and  uam.OfficeLocationID=ol.OfficeLocationID	
	join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID
	join teams on teams.TeamID=ltm.TeamID
	where ltm.UUID=@UUID and ltm.AccountCode=@AccountCode 
	and bmi.BusinessModuleCode=@BusinessModuleCode and ol.OfficeLocationCode=isnull(@OfficeLocationCode,ol.OfficeLocationCode)
	and teams.[Name]=@TeamName and ltm.ParentOrChildID!='0'
	 
	SELECT @Rows=@@ROWCOUNT;
	if(@TeamLevels is null) set @TeamLevels=0
	
	while (@Rows!=0 and (@TeamLevels>1 or @TeamLevels=0))
	begin		 
		
		set @Rows=0;
		insert into #ParentUUIDs
		select distinct ltm.ParentOrChildID   --into ##temp
		from UserTeamMapping ltm 	
		join users on users.UUID=ltm.UUID
		join UserAccountMappings uam on uam.UserID=users.UserID and uam.OfficeLocationID=ltm.OfficeLocationID
		join OfficeLocation ol on ol.OfficeLocationID=ltm.OfficeLocationID and  uam.OfficeLocationID=ol.OfficeLocationID	
		join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID
		join teams on teams.TeamID=ltm.TeamID
		where ltm.AccountCode=@AccountCode and bmi.BusinessModuleCode=@BusinessModuleCode and ol.OfficeLocationCode=isnull(@OfficeLocationCode,ol.OfficeLocationCode)
		and teams.[Name]=@TeamName and users.UUID in (SELECT * FROM #ParentUUIDs) and ltm.ParentOrChildID not in (SELECT * FROM #ParentUUIDs)
		and ltm.ParentOrChildID!='0'
		
		SELECT @Rows=@@ROWCOUNT;
	
		set @TeamLevels=@TeamLevels-1;
		
	 end	

	 select distinct ParentOrChildID UUID
	 from #ParentUUIDs 		
	 where ParentOrChildID!='0' 	
	 
	 drop table #ParentUUIDs

end


