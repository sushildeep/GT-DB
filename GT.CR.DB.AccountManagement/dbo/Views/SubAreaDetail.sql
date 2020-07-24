create view SubAreaDetail

 
as
 

select  SubAreaCode ,
        AreaCode ,
        AreaName ,
        OfficeLocationName ,
        OfficeLocationCode ,
        AccountCode ,
        AccountName ,
        SubAreaName  from [dbo].[AccountInfoes] ac 
join  [dbo].[OfficeLocation] ol on  ac.AccountInfoID = ol.AccountInfoID
join  [dbo].[LocationArea] la on ol .OfficeLocationID = la.OfficeLocationID
join [dbo].[SubAreaInfo] sa on la.LocationAreaID = sa.LocationAreaID

 

