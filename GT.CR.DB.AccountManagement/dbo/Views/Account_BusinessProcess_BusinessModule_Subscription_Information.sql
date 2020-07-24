CREATE View [dbo].[Account_BusinessProcess_BusinessModule_Subscription_Information] AS
select acc.[AccountInfoID],acc.AccountCode,acc.[AccountName], 
	bp.[BusinessProcessInfoID],bp.[BusinessProcessCode],procs.[BusinessProcessName],
	bm.[BusinessModuleInfoID],bm.[BusinessModuleCode],modl.[BusinessModuleName] from businessmoduleinfoes bm
 inner join [dbo].[BusinessProcessInfoes] bp on bm.[BusinessProcessInfoID]=bp.[BusinessProcessInfoID]
 inner join [dbo].[AccountInfoes] acc on  bp.[accountid] = acc.[accountinfoid] 
 INNER JOIN [dbo].[BusinessModules] modl on bm.[BusinessModuleCode]=modl.[BusinessModuleCode]
 INNER JOIN [dbo].[BusinessProcesses] procs on procs.[BusinessProcessCode]=bp.[BusinessProcessCode]




