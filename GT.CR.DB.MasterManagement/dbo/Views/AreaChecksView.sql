CREATE view AreaChecksView
as
  

select SubAreaCode,ChecklistCode,CheckCode,CheckTitle,ChecklistName from [dbo].[Check] c
join areachecks ac  on ac.CheckID = c.CheckID
join Checklist cl on cl.ChecklistID = ac.ChecklistID