CREATE PROCEDURE [dbo].[Sp_UploadBulkExcelData]
AS
    BEGIN

        -- INSERT INTO AUDITINFO TABLE
        INSERT INTO [dbo].[AuditInfo]
        ([AuditName], 
         [AuditImage], 
         [AssignedToUserName], 
         [AssignedToUserUUID], 
         [AuditLocation], 
         [AuditFBO], 
         [AuditScheduledStartDateTime], 
         [AuditScheduledEndDateTime], 
         [AuditExpiryDateTime], 
         [AuditType], 
         [AuditCity], 
         [AuditCategory], 
         [AuditStatus], 
         [CreatedBy], 
         [CreatedDateTime], 
         AuditLocationCode
        )
               SELECT DISTINCT 
                      [AuditName], 
                      [AuditImage], 
                      [AssignedToUserName], 
                      [AssignedToUserUUID], 
                      [AuditLocation], 
                      [AuditFBO], 
                      IIF([AuditScheduledStartDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [AuditScheduledStartDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [AuditScheduledStartDateTime]))), 
                      IIF([AuditScheduledEndDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [AuditScheduledEndDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [AuditScheduledEndDateTime]))), 
                      IIF([AuditExpiryDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [AuditExpiryDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [AuditExpiryDateTime]))), 
                      [AuditType], 
                      [AuditCity], 
                      [AuditCategory], 
                      NULL, 
                      'Excel', 
                      CURRENT_TIMESTAMP, 
                      AuditLocationCode
               FROM [dbo].[ScheduleDataExcel] X
               WHERE NOT EXISTS
               (
                   SELECT 1
                   FROM [dbo].[AuditInfo] AI
                   WHERE IIF(X.[AuditScheduledStartDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledStartDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledStartDateTime]))) = AI.[AuditScheduledStartDateTime]
                         AND IIF(X.[AuditScheduledEndDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledEndDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledEndDateTime]))) = AI.[AuditScheduledEndDateTime]
                         AND IIF(X.[AuditExpiryDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditExpiryDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditExpiryDateTime]))) = AI.[AuditExpiryDateTime]
                         AND ISNULL(X.[AuditName], '') = ISNULL(AI.AuditName, '')
                         AND ISNULL(X.[AuditImage], '') = ISNULL(AI.[AuditImage], '')
                         AND ISNULL(X.[AssignedToUserUUID], '') = ISNULL(AI.[AssignedToUserUUID], '')
                         AND ISNULL(X.[AuditLocation], '') = ISNULL(AI.[AuditLocation], '')
                         AND ISNULL(X.[AuditFBO], '') = ISNULL(AI.AuditFBO, '')
                         AND ISNULL(X.[AuditType], '') = ISNULL(AI.AuditType, '')
                         AND ISNULL(X.[AuditCity], '') = ISNULL(AI.AuditCity, '')
                         AND ISNULL(X.[AuditCategory], '') = ISNULL(AI.AuditCategory, '')
                         AND ISNULL(X.AuditLocationCode, '') = ISNULL(AI.AuditLocationCode, '')
               );

        --UPDATE AUDITCODE
        UPDATE [dbo].[AuditInfo]
          SET 
              AuditCode = 'A' + RIGHT('000000' + CONVERT(VARCHAR(6), AuditInfoID), 7)
        WHERE AuditCode IS NULL;

        --INSERT INTO AUDITCHECKLISTINFO TABLE
        INSERT INTO AuditChecklistInfo
        ([ChecklistScheduledStartDateTime], 
         [ChecklistScheduledEndDateTime], 
         [AreaName], 
         [SubAreaName], 
         [SubAreaCode]
        )
               SELECT DISTINCT 
                      IIF([ChecklistScheduledStartDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [ChecklistScheduledStartDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [ChecklistScheduledStartDateTime]))), 
                      IIF([ChecklistScheduledEndDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [ChecklistScheduledEndDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, [ChecklistScheduledEndDateTime]))), 
                      [AreaName], 
                      [SubAreaName], 
                      [SubAreaCode]
               FROM [dbo].[ScheduleDataExcel] X
               WHERE NOT EXISTS
               (
                   SELECT 1
                   FROM AuditChecklistInfo AC
                   WHERE IIF(X.[ChecklistScheduledStartDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledStartDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledStartDateTime]))) = AC.ChecklistScheduledStartDateTime
                         AND IIF(X.[ChecklistScheduledEndDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledEndDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledEndDateTime]))) = ac.ChecklistScheduledEndDateTime
                         AND ISNULL(X.[AreaName], '') = ISNULL(ac.AreaName, '')
                         AND ISNULL(X.[SubAreaName], '') = ISNULL(ac.SubAreaName, '')
                         AND ISNULL(X.[SubAreaCode], '') = ISNULL(ac.[SubAreaCode], '')
               );

        --Insert into scheduled Excel
        -- ForAuditInfoID
        UPDATE X
          SET 
              AuditInfoID = AI.AuditInfoID
        FROM [dbo].[AuditInfo] AI
             JOIN [ScheduleDataExcel] X ON IIF(X.[AuditScheduledStartDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledStartDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledStartDateTime]))) = AI.[AuditScheduledStartDateTime]
                                           AND IIF(X.[AuditScheduledEndDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledEndDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditScheduledEndDateTime]))) = AI.[AuditScheduledEndDateTime]
                                           AND IIF(X.[AuditExpiryDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditExpiryDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[AuditExpiryDateTime]))) = AI.[AuditExpiryDateTime]
                                           AND ISNULL(X.[AuditName], '') = ISNULL(AI.AuditName, '')
                                           AND ISNULL(X.[AuditImage], '') = ISNULL(AI.[AuditImage], '')
                                           AND ISNULL(X.[AssignedToUserUUID], '') = ISNULL(AI.[AssignedToUserUUID], '')
                                           AND ISNULL(X.[AuditLocation], '') = ISNULL(AI.[AuditLocation], '')
                                           AND ISNULL(X.[AuditFBO], '') = ISNULL(AI.AuditFBO, '')
                                           AND ISNULL(X.[AuditType], '') = ISNULL(AI.AuditType, '')
                                           AND ISNULL(X.[AuditCity], '') = ISNULL(AI.AuditCity, '')
                                           AND ISNULL(X.[AuditCategory], '') = ISNULL(AI.AuditCategory, '')
                                           AND ISNULL(X.AuditLocationCode, '') = ISNULL(AI.AuditLocationCode, '')
        WHERE X.AuditInfoID IS NULL;

        -- ForChecklistInfoID
        UPDATE X
          SET 
              X.[ChecklistInfoID] = AC.AuditChecklistInfoID
        FROM AuditChecklistInfo AC
             JOIN [ScheduleDataExcel] X ON IIF(X.[ChecklistScheduledStartDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledStartDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledStartDateTime]))) = AC.ChecklistScheduledStartDateTime
                                           AND IIF(X.[ChecklistScheduledEndDateTime] LIKE '%/%', DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledEndDateTime])), DATEADD(MI, DATEDIFF(MI, GETDATE(), GETUTCDATE()), CONVERT(DATETIME, X.[ChecklistScheduledEndDateTime]))) = AC.ChecklistScheduledEndDateTime
                                           AND ISNULL(X.[AreaName], '') = ISNULL(AC.AreaName, '')
                                           AND ISNULL(X.[SubAreaName], '') = ISNULL(AC.SubAreaName, '')
                                           AND ISNULL(X.[SubAreaCode], '') = ISNULL(AC.[SubAreaCode], '')
        WHERE X.[ChecklistInfoID] IS NULL;

        -- ForAreachecksID
      

				   INSERT INTO AuditCheck
        ([AuditInfoID], 
         [AuditChecklistInfoID], 
         [AuditCheckInfoID], 
         [AreaChecksID]
        )
SELECT DISTINCT 
 X.[AuditInfoID], 
 X.ChecklistInfoID, 
 NULL, 
 arc.[AreaChecksID]
     FROM [dbo].[ScheduleDataExcel] X
			   JOIN AreaChecks arc ON ISNULL(arc.SubAreaCode, '') = ISNULL(X.SubAreaCode, '')  
             JOIN Checklist c ON ISNULL(c.ChecklistCode, '') = ISNULL(X.ChecklistCode, '')
                                 AND arc.checklistid = c.[ChecklistID]
             JOIN [Check] CC ON ISNULL(CC.CheckCode, '') = ISNULL(X.CheckCode, '')
                                AND arc.[CheckID] = cc.[CheckID]


 
        EXEC TRN_sp_PublishExcelAudits;
         
    END;