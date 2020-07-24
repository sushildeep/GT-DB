CREATE procedure [dbo].[Sp_GetAuditSummaryCounts]
 @UUID [dbo].[List] READONLY
AS
    BEGIN
        SELECT Closed, 
		incomplete,
               inprogress, 
               notperformed, 
               [Open], 
               LocationName
        FROM
        (
            SELECT  AuditStatus, 
                   LocationName
            FROM [Audit] a
                 JOIN UserChecklistAuditInfos u ON u.UserChecklistAuditInfoID = a.UserChecklistAuditInfoID
				  join @UUID uu on u.UserID = uu.input  --and MONTH(a.AuditScheduledStartDateTime)=4
           
        ) T1 PIVOT(COUNT(AuditStatus) FOR AuditStatus IN(Closed, incomplete,
                                                         inprogress, 
                                                         notperformed, 
                                                         [Open])) AS T2;
    END;
 
	--declare @UUID [dbo].[List]  
 --insert into @UUID values('UU0000015') 
--Exec [Sp_GetAuditSummaryCounts] @UUID


--	declare @UUID [dbo].[List]  
--insert into @UUID values('UU0000014') 
--insert into @UUID values('UU0000016') 
--insert into @UUID values('UU0000017') 
--insert into @UUID values('UU0000018') 
--insert into @UUID values('UU0000019') 
--insert into @UUID values('UU0000020') 
--insert into @UUID values('UU0000025') 
--insert into @UUID values('UU0000026') 
--insert into @UUID values('UU0000034') 
--insert into @UUID values('UU0000035') 
--insert into @UUID values('UU0000037') 
--insert into @UUID values('UU0000038') 
--insert into @UUID values('UU0000039') 
--insert into @UUID values('UU0000040') 
--insert into @UUID values('UU0000041') 
--insert into @UUID values('UU0000042') 
--insert into @UUID values('UU0000043') 
--insert into @UUID values('UU0000044') 
--insert into @UUID values('UU0000045') 
--insert into @UUID values('UU0000059') 
--insert into @UUID values('UU0000060') 
--insert into @UUID values('UU0000061') 
--Exec [Sp_GetAuditSummaryCounts] @UUID