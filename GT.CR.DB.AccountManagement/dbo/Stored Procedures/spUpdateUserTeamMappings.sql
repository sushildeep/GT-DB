
CREATE Procedure [dbo].[spUpdateUserTeamMappings] @UserTeamMapping UserTeamMappingType readonly
as begin

SET NOCOUNT ON;    
  
DECLARE @LocationCode varchar(max), @TeamCode varchar(15), @UUID varchar(15), @ParentUserUUID varchar(15)
  
  
DECLARE TeamMapping_Cursor CURSOR FOR     
SELECT LocationCode, TeamCode, UUID, ParentUserUUID
FROM @UserTeamMapping      
  
OPEN TeamMapping_Cursor    
  
FETCH NEXT FROM TeamMapping_Cursor     
INTO @LocationCode, @TeamCode, @UUID, @ParentUserUUID
  
WHILE @@FETCH_STATUS = 0    
BEGIN    
  
if @ParentUserUUID is null 
begin

  if exists (select 1 from UserTeamMapping where UUID=@UUID and ParentOrChildID='0'
  and TeamID=(select teamid from teams where TeamCode=@TeamCode)
  and OfficeLocationID=(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode))
  begin 
  print 'User is already Superiour in this Team'
  end

 else if exists (select 1 from UserTeamMapping where UUID=@UUID  and ParentOrChildID!='0'
  and TeamID=(select teamid from teams where TeamCode=@TeamCode)
  and OfficeLocationID=(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode))
  
  begin

  
 update a set updatedby='AMTeam',LastModifiedDate=getdate(), status='InActive'
--select *
from UserTeamMapping a
where UUID=@UUID and TeamID=(select teamid from teams where TeamCode=@TeamCode) and ParentOrChildID !='0'
and OfficeLocationID=(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode)


insert into UserTeamMapping([TeamID], [UUID], [AccountCode], [ParentOrChildID], [Status], [CreatedBy], [CreatedDate], [OfficeLocationID])
select teams.TeamID, @UUID, acinf.AccountCode,0,'Active','AMTeam',getdate(),(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode)
from teams
join Departments dpt on dpt.DepartmentID=teams.DepartmentID
join AccountInfoes acinf on acinf.AccountInfoID=dpt.AccountInfoID
where teams.TeamCode=@TeamCode

end

 else if not exists (select 1 from UserTeamMapping where UUID=@UUID and ParentOrChildID!='0'
  and TeamID=(select teamid from teams where TeamCode=@TeamCode)
  and OfficeLocationID=(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode))
   
begin 


insert into UserTeamMapping([TeamID], [UUID], [AccountCode], [ParentOrChildID], [Status], [CreatedBy], [CreatedDate], [OfficeLocationID])
select teams.TeamID, @UUID, acinf.AccountCode,0,'Active','AMTeam',getdate(),(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode)
from teams
join Departments dpt on dpt.DepartmentID=teams.DepartmentID
join AccountInfoes acinf on acinf.AccountInfoID=dpt.AccountInfoID
where teams.TeamCode=@TeamCode

end

end

else if @ParentUserUUID is not null  
begin

 if not exists (select 1 from UserTeamMapping where UUID=@UUID and ParentOrChildID=@ParentUserUUID
  and TeamID=(select teamid from teams where TeamCode=@TeamCode) and OfficeLocationID=
  (select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode))
  
  begin

 if exists (select 1 from UserTeamMapping where UUID=@ParentUserUUID 
  and TeamID=(select teamid from teams where TeamCode=@TeamCode) and OfficeLocationID=
  (select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode))
  
  begin

  
insert into UserTeamMapping([TeamID], [UUID], [AccountCode], [ParentOrChildID], [Status], [CreatedBy], [CreatedDate], [OfficeLocationID])
select teams.TeamID, @UUID, acinf.AccountCode,@ParentUserUUID,'Active','AMTeam',getdate(),(select OfficeLocationID from OfficeLocation where OfficeLocationCode=@LocationCode)
from teams
join Departments dpt on dpt.DepartmentID=teams.DepartmentID
join AccountInfoes acinf on acinf.AccountInfoID=dpt.AccountInfoID
where teams.TeamCode=@TeamCode

end

else
begin
print 'No Such Superiour is Mapped in this Team'
end

end

else
begin
print 'User is already Superiour in this Team'
end
end
  
    FETCH NEXT FROM TeamMapping_Cursor     
INTO @LocationCode, @TeamCode, @UUID, @ParentUserUUID
   
END     
CLOSE TeamMapping_Cursor;    
DEALLOCATE TeamMapping_Cursor;    


end



--CREATE TYPE UserTeamMappingType AS TABLE   
--( 
--LocationCode VARCHAR(max), 
--TeamCode  VARCHAR(15), 
--UUID VARCHAR(15),  
--ParentUserUUID VARCHAR(15)
--);
