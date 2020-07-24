CREATE PROCEDURE [dbo].[Sp_GetAllChecklist]
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
               SubAreaCode, 
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
                   SubAreaCode, 
                   COUNT(DISTINCT ch.CheckCode) TotalChecks, 
                   SUM(ch.Score) MaxScore
            FROM [dbo].[Checklist] c
                 JOIN [dbo].[AreaChecks] a ON c.ChecklistID = a.ChecklistID
                 JOIN [dbo].[Check] ch ON ch.CheckID = a.CheckID
            GROUP BY ChecklistCode, 
                     SubAreaCode
        ) i
        JOIN [dbo].[Checklist] c ON i.ChecklistCode = c.ChecklistCode 
	order by c.ChecklistID;

	
		
        --select c.*,Checks#,i.MaxScore 
        --from (
        --select distinct ChecklistCode,SubAreaCode,count(distinct ch.CheckCode) Checks#,sum(ch.Score) MaxScore
        --from [dbo].[Checklist] c 
        --join [dbo].[AreaChecks] a on c.ChecklistID = a.ChecklistID
        --join [dbo].[Check] ch on ch.CheckID = a.CheckID
        --group by ChecklistCode,SubAreaCode) i
        --join [dbo].[Checklist] c  on i.ChecklistCode=c.ChecklistCode

    END;