


CREATE VIEW [dbo].[Vw_AuditChecklistChecks]
AS
SELECT      dbo.AuditCheck.CheckCode, dbo.AuditCheck.CheckName, dbo.AuditCheck.CheckImage, dbo.AuditCheck.CheckResponse, dbo.AuditCheck.CheckAnswer, 
			dbo.AuditCheck.PerformedDateTime, dbo.AuditCheck.Remark, dbo.AuditCheck.CheckScore, dbo.AuditCheck.CheckType, dbo.AuditCheck.CheckCategory, 
			dbo.AuditCheck.AuditCheckID, dbo.AuditChecklist.ChecklistName, dbo.AuditChecklist.AuditChecklistID, dbo.AuditChecklist.ChecklistCode, dbo.AuditChecklist.ChecklistIcon,
			dbo.AuditChecklist.ChecklistCategory, dbo.AuditChecklist.ChecklistType, dbo.AuditChecklist.ChecklistDescription, dbo.AuditChecklist.ChecklistStartDateTime, 
			dbo.AuditChecklist.ChecklistEndDateTime, dbo.AuditChecklist.ChecklistDepartment, dbo.AuditChecklist.ChecklistArea, dbo.AuditChecklist.ChecklistSubArea, 
            dbo.AuditChecklist.PerformedBy, dbo.AuditChecklist.PerformedRole, dbo.AuditChecklist.ChecklistStatus, dbo.AuditChecklist.TotalYesResponse, 
			dbo.AuditChecklist.TotalNoResponse, dbo.AuditChecklist.TotalScore, dbo.AuditChecklist.MaxScore, dbo.AuditChecklist.ChecklistCompliancePercentage, 
			dbo.AuditChecklist.Pinned, dbo.AuditChecklist.ChecklistObservation, dbo.Audit.*,dbo.UserChecklistAuditInfos.FBO,dbo.UserChecklistAuditInfos.LocationName,dbo.UserChecklistAuditInfos.UserID,
			dbo.UserChecklistAuditInfos.City,dbo.Attachement.AttachementName, dbo.Attachement.[Location] AttachmentLocation, dbo.Attachement.Latitude AttachmentLatitude, 
			dbo.Attachement.Longitude AttachmentLongitude, dbo.Attachement.[DateTime] AttachmentDateTime
FROM            dbo.Audit INNER JOIN
            dbo.AuditChecklist ON dbo.Audit.AuditID = dbo.AuditChecklist.AuditID INNER JOIN
            dbo.AuditCheck ON dbo.AuditChecklist.AuditChecklistID = dbo.AuditCheck.AuditChecklistID
INNER JOIN dbo.UserChecklistAuditInfos
			on(dbo.UserChecklistAuditInfos.UserChecklistAuditInfoID = dbo.Audit.UserChecklistAuditInfoID)
left JOIN dbo.Attachement
			on(dbo.AuditCheck.AuditCheckID = dbo.Attachement.AuditCheckID)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Vw_AuditChecklistChecks';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Audit"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 286
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AuditCheck"
            Begin Extent = 
               Top = 1
               Left = 659
               Bottom = 131
               Right = 855
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "AuditChecklist"
            Begin Extent = 
               Top = 1
               Left = 331
               Bottom = 131
               Right = 591
            End
            DisplayFlags = 280
            TopColumn = 24
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1995
         Alias = 900
         Table = 1635
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'Vw_AuditChecklistChecks';

