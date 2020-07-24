-- =============================================  
-- Author:  <Mahesh Kumar KB>  
-- ALTER date: <30-07-2018>  
-- Description: <Description,,>  
-- =============================================  
--exec spGetALLUserLocationRolesByAccountAndModuleCode 'UU0000001','LOB000001','BM0000001','MCD0000001'
CREATE Procedure [dbo].[spGetALLUserLocationRolesByAccountAndModuleCode] 

 -- Add the parameters for the stored procedure here  
 @uuid varchar(max),  
 @accountCode varchar(max),  
 @businessModuleCode varchar(max),
 @LocationCode varchar(max)
AS  
BEGIN  
  
DECLARE @resultCount INT=0;  
  
 
 SET NOCOUNT ON;  
  
select distinct mr.RoleCode,roles.Rolename into #temp from [UserLocationRole] ulr
join [UserAccountMappings] uam on uam.userid=ulr.UserID
join AccountInfoes ainf on ainf.AccountInfoID=uam.AccountInfoID
join BusinessModuleInfoes bmi on bmi.BusinessModuleInfoID=uam.BusinessModuleInfoID
join Roles on roles.RoleID=ulr.RoleID 
join users on users.userid=ulr.userid
join OfficeLocation ol on ol.OfficeLocationID=ulr.OfficeLocationID and ol.OfficeLocationID=uam.OfficeLocationID
join MasterRoles mr on mr.MasterRoleId=roles.MasterRoleId
where users.UUID=@uuid and ainf.AccountCode=@accountCode and bmi.BusinessModuleCode=@businessModuleCode
and ol.OfficeLocationCode=@LocationCode

select @resultCount=count(*) from #temp  
    
 DECLARE @accountExist BIT,@UUIDExist BIT,@businessModuleExist BIT,@LocationCodeExist BIT;  
  
  
if(@resultCount=0)  
BEGIN  
  
EXEC spMasterIsAccountExistByAccountCode @accountCode, @accountExist = @accountExist OUTPUT  
  
 IF(@accountExist=1)   
 begiN  
   
  
 EXEC spMasterIsBusinessModuleExistByBusinessModuleCode @businessModuleCode, @businessModuleExist = @businessModuleExist OUTPUT  
  
 IF(@businessModuleExist=1)   
 begin  
    
  
EXEC spMasterIsUserExistByUUID @UUID,@userExist=@UUIDExist OUTPUT  
  
IF(@UUIDExist=0)   
  BEGIN  
      
  -- ROLE does not exist  
  
     -- Throw exception   
       
   
     RAISERROR('UUID DOES NOT EXIST',16,1)  
  
  END  
  
 END   
     
  else  
  begin  
   
     RAISERROR('BUSINESS MODULE DOES NOT EXIST',16,1)  
  
  END   
  END   
 ELSE   
  BEGIN  
  
  -- LOB DOES NOT EXIST  
  
     -- Throw exception   
    
  
     RAISERROR('LOB DOES NOT EXIST',16,1)  
  
  END   
END  

else  
begin   
select * from #temp 
END  
   
IF OBJECT_ID('tempdb.dbo.#temp', 'U') IS NOT NULL   
drop table #temp  
END  
  
  
  
  
  
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
