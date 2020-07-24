CREATE PROCEDURE [dbo].[Sp_GetAllChecklistBySubAreas] 

@SubAreaCodes  [dbo].[SubAreaCodes] readonly
AS
    BEGIN
        SELECT ChecklistID, 
               NULL AreaName, 
               NULL SubAreaName, 
               c.ChecklistCode, 
               ChecklistName, 
               ChecklistDescription, 
               STATUS ChecklistStatus, 
               CreatedBy, 
               CreatedDateTime, 
               i.SubAreaCode, 
               [TotalChecks] TotalNoOfChecks, 
               i.MaxScore, 
               [LastModifiedBy], 
               [LastModifiedDateTime],
			   [ChecklistIcon],
			   [ChecklistCategory],
			   [ChecklistType],
			   [Status]
        FROM
        (
            SELECT DISTINCT 
                   ChecklistCode, 
                   a.SubAreaCode, 
                   COUNT(DISTINCT ch.CheckCode) TotalChecks, 
                   SUM(ch.Score) MaxScore
            FROM [dbo].[Checklist] c
                 JOIN [dbo].[AreaChecks] a ON c.ChecklistID = a.ChecklistID 
				 JOIN @SubAreaCodes u on u.[SubAreaCode]=a.SubAreaCode
                 JOIN [dbo].[Check] ch ON ch.CheckID = a.CheckID
            GROUP BY ChecklistCode, 
                     a.SubAreaCode
        ) i
        JOIN [dbo].[Checklist] c ON i.ChecklistCode = c.ChecklistCode
		order by ChecklistName;

     




    END;