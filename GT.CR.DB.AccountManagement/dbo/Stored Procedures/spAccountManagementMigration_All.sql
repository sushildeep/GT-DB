-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE Procedure [dbo].[spAccountManagementMigration_All] -- execute [dbo].[spAccountManagementCursor] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

		DECLARE @INP_Business_Process nvarchar(100) 
		DECLARE @INP_Modules nvarchar(100) 
		DECLARE @INP_Feature nvarchar(100) 
		DECLARE @INP_Privellages_List_Of_Privellages nvarchar(100) 
		DECLARE @INP_Super_Admin nvarchar(100) 
		DECLARE @INP_Admin nvarchar(100) 
		DECLARE @INP_Billing_Lead nvarchar(100) 
		DECLARE @INP_Quality_Checker nvarchar(100) 
		DECLARE @INP_Biller nvarchar(100) 
		DECLARE @INP_Provider nvarchar(100) 

		DECLARE @P_CreatedBy nvarchar(100) = 'AMTeam'
		DECLARE @P_CreatedDate datetime = CURRENT_TIMESTAMP
		DECLARE @P_UpdatedBy nvarchar(100) = 'AMTeam'
		DECLARE @P_LastModifiedDate datetime = CURRENT_TIMESTAMP

		DECLARE @P_BusinessProcessID bigint
		DECLARE @P_BusinessModuleID bigint
		DECLARE @P_PrivilegeID bigint
	
	-- insert into select * from [BusinessProcesses]
	INSERT INTO [dbo].[BusinessProcesses]
	([BusinessProcessCode], [BusinessProcessName],
	 [CreatedBy], [CreatedDate],
	 [UpdatedBy], [LastModifiedDate]
	)

	SELECT 'BP' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber))) + CONVERT(varchar, RowNumber)[code], [Business_Process], 
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
	FROM (
			SELECT (SELECT CASE WHEN MAX(convert(int, REPLACE([BusinessProcessCode],'BP',''))) is null
							THEN 0
							ELSE (MAX(CONVERT(int, REPLACE([BusinessProcessCode],'BP',''))))
							END
					FROM [dbo].[BusinessProcesses] )
					+ (ROW_NUMBER() OVER (ORDER BY [Business_Process])  ) AS RowNumber
					, [Business_Process]
			FROM (SELECT DISTINCT [Business_Process] FROM [dbo].[P_User_Information]) temp1
			WHERE NOT EXISTS (SELECT 1 FROM [dbo].[BusinessProcesses] WHERE [BusinessProcessName] = [Business_Process])
		) temp

 

	-- insert into select * from BusinessModules
	INSERT INTO [dbo].[BusinessModules]
	(
		[BusinessModuleName], [BusinessModuleCode], [BusinessProcessID],
		[CreatedBy], [CreatedDate],
		[UpdatedBy], [LastModifiedDate]

	)
	SELECT [Module], 'BM' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber))) + CONVERT(varchar, RowNumber)[code], [bpid], 
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
	FROM (
			SELECT (SELECT CASE WHEN MAX(convert(int, REPLACE([BusinessModuleCode],'BM',''))) is null
							THEN 0
							ELSE (MAX(CONVERT(int, REPLACE([BusinessModuleCode],'BM',''))))
							END
					FROM [dbo].[BusinessModules] )
					+ (ROW_NUMBER() OVER (ORDER BY bpid)  ) AS RowNumber
					, [Module]
					,[bpid]
			FROM (SELECT DISTINCT [BusinessProcessID][bpid], [Module] 
					FROM [dbo].[P_User_Information]
					join [dbo].[BusinessProcesses]
					on [Business_Process] = [BusinessProcessName]
				) temp1
			WHERE NOT EXISTS (SELECT 1 FROM [dbo].[BusinessModules] 
									   WHERE [BusinessModuleName] = [Module] and [BusinessProcessID] = [bpid])
	 ) temp

	 
	-- insert into Business privileges -- select * from [Privileges]
	insert into [dbo].[Privileges]
	(
		[PrivilegeCode],
		[PrivilegeName],
		[BusinessModuleID],
		[CreatedBy], [CreatedDate],
		[UpdatedBy], [LastModifiedDate],[status]
	)
	select distinct t1.[Privellage_Code], t1.[Privellages_List_Of_Privellages],t3.[BusinessModuleID],
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP,'ACTIVE'
	from [dbo].[P_User_Privileges_Priorities] t1
	join [dbo].[BusinessProcesses] t2
	on t1.[Business_Process] = t2.[BusinessProcessName]
	join [dbo].[BusinessModules] t3
	on t3.[BusinessModuleName] = t1.[Modules] and t2.[BusinessProcessID] = t3.[BusinessProcessID]
	where not exists ( select 1 from [Privileges] t where t.[PrivilegeCode] = t1.[Privellage_Code]
													and t.[PrivilegeName] = t1.[Privellages_List_Of_Privellages]
													and t.[BusinessModuleID] = t3.[BusinessModuleID])
	
	 
	 
	-- INSERT INTO [dbo].[Users]
	
	

 INSERT INTO [dbo].[Users] 
	(
		[UUID],
		[UserName],
		[First_Name]
		,[Last_Name]
		,[Middle_Name]
		 
		,[CreatedBy]
		,[CreatedDate]
		,[UpdatedBy]
		,[LastModifiedDate],[UserType]

	)
SELECT 'UU' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber))) + CONVERT(varchar, RowNumber)[code], 
			ExpectedUserName, [FirstName]
						,[LastName], [MiddleName] ,
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP,'ApplicationUser'
	FROM (
			SELECT (SELECT CASE WHEN MAX(convert(int, REPLACE([UUID],'UU',''))) is null
							THEN 0
							ELSE (MAX(CONVERT(int, REPLACE([UUID],'UU',''))))
							END
					FROM [dbo].[Users] )
					+ (ROW_NUMBER() OVER (ORDER BY ExpectedUserName)  ) AS RowNumber
					, ExpectedUserName
					, [FirstName]
					,[LastName], [MiddleName]
			FROM (select distinct [FirstName],[LastName],[MiddleName],ExpectedUserName from [ProviderServicesDBForClaimsDemo].[dbo].[ProvidersData_UUID] where am_UUID is   null ) temp1
			WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserName] = ExpectedUserName)
		) temp




		--insert into [dbo].[UserContactInfo]
		--select 'PHONE',[Primary_Phone_Number],1,u.[UserID],
		--	'AMTeam' ,CURRENT_TIMESTAMP,
		--	'AMTeam' ,CURRENT_TIMESTAMP
		--from [dbo].[P_User_Information] PU
		--join users u on u.[UserName] = PU.[User_Name]
		--join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		--where pu.[Primary_Phone_Number] is not null and pu.[Primary_Phone_Number]!='' and
		--  pu.[Primary_Phone_Number] not in
		-- (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='PHONE')

		--select * from [dbo].[P_User_Information]

		 insert into [dbo].[UserContactInfo]--0
		select 'EMAIL',[Primary_Email_Id],1,u.[UserID],
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
		from [dbo].[P_User_Information] PU
		join users u on u.[UserName] = PU.[User_Name]
		join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		where pu.[Primary_Email_Id] is not null and pu.[Primary_Email_Id]!='' and
		  pu.[Primary_Email_Id] not in
		 (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='EMAIL')



		 insert into [dbo].[UserContactInfo]--0
		select 'EMAIL',[Email_Id],0,u.[UserID],
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
		from [dbo].[P_User_Information] PU
		join users u on u.[UserName] = PU.[User_Name]
		join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		where pu.[Email_Id] is not null and pu.[Email_Id]!='' and
		  pu.[Email_Id] not in
		 (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='EMAIL')


		--  insert into [dbo].[UserContactInfo]
		--select 'HOME_PHONE_NUMBER',[Home_Phone_Number],0,u.[UserID],
		--	'AMTeam' ,CURRENT_TIMESTAMP,
		--	'AMTeam' ,CURRENT_TIMESTAMP
		--from [dbo].[P_User_Information] PU
		--join users u on u.[UserName] = PU.[User_Name]
		--join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		--where pu.[Home_Phone_Number] is not null and pu.[Home_Phone_Number]!='' and
		--  pu.[Home_Phone_Number] not in
		-- (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='HOME_PHONE_NUMBER')


		-- insert into [dbo].[UserContactInfo]
		--select 'OFFICE_PHONE_NUMBER',[Office_Phone_Number],0,u.[UserID],
		--	'AMTeam' ,CURRENT_TIMESTAMP,
		--	'AMTeam' ,CURRENT_TIMESTAMP
		--from [dbo].[P_User_Information] PU
		--join users u on u.[UserName] = PU.[User_Name]
		--join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		--where pu.[Office_Phone_Number] is not null and pu.[Office_Phone_Number]!='' and
		--  pu.[Office_Phone_Number] not in
		-- (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='OFFICE_PHONE_NUMBER')



		-- insert into [dbo].[UserContactInfo]
		--select 'FAX',[Fax_Number],0,u.[UserID],
		--	'AMTeam' ,CURRENT_TIMESTAMP,
		--	'AMTeam' ,CURRENT_TIMESTAMP
		--from [dbo].[P_User_Information] PU
		--join users u on u.[UserName] = PU.[User_Name]
		--join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		--where pu.[Fax_Number] is not null and pu.[Fax_Number]!='' and
		--  pu.[Fax_Number] not in
		-- (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='FAX')

		--insert into [dbo].[UserContactInfo]
		--select 'FAX',[Primary_Fax_Number],1,u.[UserID],
		--	'AMTeam' ,CURRENT_TIMESTAMP,
		--	'AMTeam' ,CURRENT_TIMESTAMP
		--from [dbo].[P_User_Information] PU
		--join users u on u.[UserName] = PU.[User_Name]
		--join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		--where pu.[Primary_Fax_Number] is not null and pu.[Primary_Fax_Number]!='' and
		--  pu.[Primary_Fax_Number] not in
		-- (select [ContactValue] from [UserContactInfo] where [UserID]=u.[UserID] and [ContactType]='FAX')



		INSERT INTO [dbo].[UserAddress]--0
		 select [Address_Line_1],[Address_Line_2],[Street],[City],[County],[State],[Country],[Zip],u.[UserID],
			'OFFICE',1,
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
		from [dbo].[P_User_Information] PU
		join users u on u.[UserName] = PU.[User_Name]
		join [UserContactInfo] uc on uc.[UserID]=u.[UserID]
		where (PU.[Address_Line_1] is not null OR PU.[City] IS NOT NULL) and
		 u.[UserID] not in
		 (select [UserID] from [UserAddress])







	-- INSERT INTO select * from [dbo].[BusinessProcessInfoes]
	INSERT INTO [dbo].[BusinessProcessInfoes] --0
	(
		[BusinessProcessCode],[AccountID],[SubscribedDate]
		,[CreatedBy]
		,[CreatedDate]
		,[UpdatedBy]
		,[LastModifiedDate]		
	)

	select distinct  [BusinessProcessCode], [AccountInfoID], CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
	FROM [dbo].[P_User_Information]  
	join [dbo].[AccountInfoes] t1
	on [Account_Name] = [AccountName] and [Category] = 'LOB'
	join [dbo].[BusinessProcesses] t2
	on [Business_Process] = [BusinessProcessName]
	where not exists (select 1 
						from [dbo].[BusinessProcessInfoes] t 
						where t2.[BusinessProcessCode] = t.[BusinessProcessCode] and t1.[AccountInfoID] = t.[AccountID])

	--INSERT INTO select * from [dbo].[BusinessModuleInfoes]
	
	INSERT INTO [dbo].[BusinessModuleInfoes]--0
	(
		[BusinessModuleCode], [BusinessProcessInfoID]
		,[CreatedBy]
		,[CreatedDate]
		,[UpdatedBy]
		,[LastModifiedDate]

	)			
	select distinct  [BusinessModuleCode], [BusinessProcessInfoID]
			,'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP
	FROM [dbo].[P_User_Information]  
	join [dbo].[AccountInfoes]
	on [Account_Name] = [AccountName] and [Category] = 'LOB'
	join [dbo].[BusinessProcesses] t1
	on [Business_Process] = [BusinessProcessName]
	join [dbo].[BusinessProcessInfoes] t2
	on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] and [AccountInfoID] = t2.[AccountID]
	join [dbo].[BusinessModules] t3
	on t3.[BusinessModuleName] = [Module]
	where not exists (select 1 
						from [dbo].[BusinessModuleInfoes] t 
						where t3.[BusinessModuleCode] = t.[BusinessModuleCode] and t2.[BusinessProcessInfoID] = t.[BusinessProcessInfoID])
		
		
		
----------------Dependency with Business Module Info Table 
--INSERT INTO select * from [dbo].[UserAccountMappings]
	INSERT INTO [dbo].[UserAccountMappings] --554
	(
		[AccountInfoID]
		,[UserID]
		,[CreatedBy]
		,[CreatedDate]
		,[LastModifiedBy]
		,[LastModifiedDate]
		,[BusinessModuleInfoID],[status],[ModuleToggleOrder]
	)
	select distinct  [AccountInfoID], t2.[UserID],
			'AMTeam' ,CURRENT_TIMESTAMP,
			'AMTeam' ,CURRENT_TIMESTAMP,
			t4.[BusinessModuleInfoID],'ACTIVE',null
			FROM [dbo].[P_User_Information]
	join [dbo].[AccountInfoes] t1
	on t1.[AccountName] = [Account_Name] and   [Category]='LOB'
	join [dbo].[Users] t2
	on [User_Name] = [UserName]  
	join [dbo].[BusinessModules] t3
	on t3.[BusinessModuleName] = [Module]
	join [dbo].[BusinessModuleInfoes] t4
	on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] 
	join businessProcessinfoes bpi on bpi.AccountID=t1.accountinfoId and t4.BusinessProcessInfoID=bpi.BusinessProcessInfoID  
	join  BusinessProcesses bp on bpi.BusinessProcessCode=bp.BusinessProcessCode and bp.[BusinessProcessName]= Business_Process
	 where
	 not exists (select 1 
						from [dbo].[UserAccountMappings] t 
						where t2.[UserID] = t.[UserID] and t1.[AccountInfoID] = t.[AccountID] and t4.[BusinessModuleInfoID]=t.[BusinessModuleInfoID])
			
-- INSERT INTO select * from [dbo].[Departments]

	INSERT INTO [dbo].[Departments] --0
	(
		[DepartmentCode], [Name],[BusinessModuleInfoID]
		,[CreatedBy]
		,[CreatedDate]
		,[UpdatedBy]
		,[LastModifiedDate],[AccountInfoID] 

	)
	SELECT 'DD' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber))) + CONVERT(varchar, RowNumber)[code], 
				[Department], [BusinessModuleInfoID]
				,'AMTeam' ,CURRENT_TIMESTAMP,
				'AMTeam' ,CURRENT_TIMESTAMP,[AccountInfoID]
		from (
			SELECT (SELECT CASE WHEN MAX(convert(int, REPLACE([DepartmentCode],'DD',''))) is null
							THEN 0
							ELSE (MAX(CONVERT(int, REPLACE([DepartmentCode],'DD',''))))
							END
					FROM [dbo].[Departments] )
					+ (ROW_NUMBER() OVER (ORDER BY [Department])  ) AS RowNumber,
					[Department], [BusinessModuleInfoID],[AccountInfoID]
			from (
				select distinct  [Department], t4.[BusinessModuleInfoID],[AccountInfoID]
				FROM [dbo].[P_User_Information] t0 
				join [dbo].[AccountInfoes]
				on t0.[Account_Name] = [AccountName] and 'LOB' = [Category]
				join [dbo].[BusinessProcesses] t1
				on t0.[Business_Process] = t1.[BusinessProcessName]
				join [dbo].[BusinessProcessInfoes] t2
				on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] and [AccountInfoID] = t2.[AccountID]
				join [dbo].[BusinessModules] t3
				on t3.[BusinessModuleName] = t0.[Module]
				join [dbo].[BusinessModuleInfoes] t4
				on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] and t4.[BusinessProcessInfoID] = t2.[BusinessProcessInfoID]
				where not exists (select 1
					from [dbo].[Departments] t 
					where isnull(t0.[Department], '123456') = isnull(t.[Name], '123456') and t4.[BusinessModuleInfoID] = t.[BusinessModuleInfoID])
				AND [Department] is not null
			) temp1
			)temp 

	--INSERT INTO [Teams]

	INSERT INTO [Teams]--0
	(
		[TeamCode], [Name], [DepartmentID]
		,[CreatedBy]
		,[CreatedDate]
		,[UpdatedBy]
		,[LastModifiedDate] 

	)

	SELECT 'TM' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber))) + CONVERT(varchar, RowNumber)[code], 
				[Team], [DepartmentID]
				,'AMTeam' ,CURRENT_TIMESTAMP,
				'AMTeam' ,CURRENT_TIMESTAMP
		from (
		SELECT (SELECT CASE WHEN MAX(convert(int, REPLACE([TeamCode],'TM',''))) is null
							THEN 0
							ELSE (MAX(CONVERT(int, REPLACE([TeamCode],'TM',''))))
							END
					FROM [dbo].[Teams] )
					+ (ROW_NUMBER() OVER (ORDER BY [Team])  ) AS RowNumber,
					[Team], [DepartmentID]
		from (
  select distinct  [Team], [DepartmentID]
  FROM [dbo].[P_User_Information]  
  join [dbo].[AccountInfoes]
  on [Account_Name] = [AccountName] and [Account_Type] = [Category]
  join [dbo].[BusinessProcesses] t1
  on [Business_Process] = [BusinessProcessName]
  join [dbo].[BusinessProcessInfoes] t2
  on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] and [AccountInfoID] = t2.[AccountID]
  join [dbo].[BusinessModules] t3
  on [BusinessModuleName] = [Module]
  join [dbo].[BusinessModuleInfoes] t4
  on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] and t4.[BusinessProcessInfoID] = t2.[BusinessProcessInfoID]
  join [dbo].[Departments] t5
  on isnull([Department], '123456') = isnull(t5.[Name], '123456') and t4.[BusinessModuleInfoID] = t5.[BusinessModuleInfoID]
  where not exists (select 1
					from [dbo].[Teams] t 
					where [Team] = t.[Name] and t5.[DepartmentID] = t.[DepartmentID])
) temp1
)temp 

  ----INSERT INTO Temp_Roles
  ---   select * from Temp_Roles



	INSERT INTO Temp_Roles (rolesample)

	
	select distinct [Name] from [Roles_table]
	except
	Select distinct RoleName  from Roles
	

	--select * from Roles



	--insert into roles
	-- ( rolecode, rolename, [AccountID], [CreatedBy]
	--	,[CreatedDate]
	--	,[UpdatedBy]
	--	,[LastModifiedDate] )

	--	SELECT 'RR' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber))) + CONVERT(varchar, RowNumber)[code], [rolesample], [AccountInfoID],
	--		'AMTeam' ,CURRENT_TIMESTAMP,
	--		'AMTeam' ,CURRENT_TIMESTAMP
	--FROM (
	--		SELECT (SELECT CASE WHEN MAX(convert(int, REPLACE(rolecode,'RR',''))) is null
	--						THEN 0
	--						ELSE (MAX(CONVERT(int, REPLACE(rolecode,'RR',''))))
	--						END
	--				FROM [dbo].[roles] )
	--				+ (ROW_NUMBER() OVER (ORDER BY [rolesample])  ) AS RowNumber
	--				, [rolesample], [AccountInfoID]
	--		FROM (select distinct [rolesample], [AccountInfoID] from [Temp_Roles] t1
	--				join [dbo].[AccountInfoes]t2
	--				on 1=1) temp1
	--		WHERE NOT EXISTS (SELECT 1 FROM [dbo].[roles]t3 WHERE [rolesample] = t3.rolename)
	--	) temp


	---- INSERT INTO [dbo].[RolePrivileges]
	--select * from [dbo].[RolePrivileges]
	INSERT INTO [dbo].[RolePrivileges]
	(	[RoleID],
		[AccountCode],
		[BusinessProcessInfoID],
		[BusinessModuleInfoID],
		[PrivilegeCode],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate],[status],[BusinessModuleCode]
	)
	select distinct t5.[RoleID], t6.[AccountCode],
					t2.[BusinessProcessInfoID], t4.[BusinessModuleInfoID],
					 [Privellage_Code]
					,'AMTeam' ,CURRENT_TIMESTAMP,
				'AMTeam' ,CURRENT_TIMESTAMP,'ACTIVE',t3.[BusinessModuleCode]
				FROM Prestage_User_Privileges_Priorities 
				join [dbo].[BusinessProcesses] t1
				on [Business_Process] = [BusinessProcessName]
				join [dbo].[BusinessProcessInfoes] t2
				on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] 
				join [dbo].[BusinessModules] t3
				on [BusinessModuleName] = [Modules]
				join [dbo].[BusinessModuleInfoes] t4
				on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] and t4.[BusinessProcessInfoID] = t2.[BusinessProcessInfoID]
				join [dbo].[Roles] t5
				on t5.[RoleName] = 'UM_Admin' and t2.[AccountID] = t5.[AccountID]
				join [dbo].[AccountInfoes] t6
				on t6.[AccountInfoID] = t5.[AccountID]
				-- join [dbo].[Privileges] t7 on 1=1
				--on t7.[PrivilegeCode] = PrivilegeCode and t7.BusinessModuleID=t4.[BusinessModuleInfoID]
				where  [SuperAdmin] = 'Yes'
				and not exists( select 1 from [dbo].[RolePrivileges] t where t5.[RoleID] = t.[RoleID] 
								and t6.[AccountCode] = t.[AccountCode]
								and t2.[BusinessProcessInfoID] = t. [BusinessProcessInfoID] 
								and t4.[BusinessModuleInfoID] = t.[BusinessModuleInfoID]
								and  [Privellage_Code] = t.[PrivilegeCode])
	
	
	--INSERT INTO [dbo].[TeamMappings]
	INSERT INTO [dbo].[TeamMappings]	--88
	(	[TeamID],
		[UUID],
		[AccountCode],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate],[TeamNodeType] 

	)		
	select 
	distinct  t6.[Teamid], t7.[UUID], [AccountCode]
	,'AMTeam', CURRENT_TIMESTAMP, 'AMTeam', CURRENT_TIMESTAMP, 'CHILD'
  FROM [dbo].[P_User_Information]  
  join [dbo].[AccountInfoes]
  on [Account_Name] = [AccountName] and [Account_Type] = [Category]
  join [dbo].[BusinessProcesses] t1
  on [Business_Process] = [BusinessProcessName]
  join [dbo].[BusinessProcessInfoes] t2
  on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] and [AccountInfoID] = t2.[AccountID]
  join [dbo].[BusinessModules] t3
  on [BusinessModuleName] = [Module]
  join [dbo].[BusinessModuleInfoes] t4
  on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] and t4.[BusinessProcessInfoID] = t2.[BusinessProcessInfoID]
  join [dbo].[Departments] t5
  on isnull([Department], '123456') = isnull(t5.[Name], '123456') and t4.[BusinessModuleInfoID] = t5.[BusinessModuleInfoID]
	join [dbo].[Teams] t6 
	on t6.[Name] = team and t6.[DepartmentID] = t5.[DepartmentID]
	join [dbo].[Users] t7
	on t7.[UserName] = [User_Name]
	and not exists( select 1 from [dbo].[TeamMappings] t where t6.[TeamID] = t.[TeamID] and t7.[UUID] = t.[UUID]
								and [AccountCode] = t. [AccountCode] )

	--INSERT INTO from [dbo].[UserTeams]
	INSERT INTO [dbo].[UserTeams]--88
	(	[AccountCode],
		[BusinessProcessInfoID],
		[BusinessModuleInfoID],
		[DepartmentCode],
		[TeamID],
		[UserID],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate]

	)		
	select distinct  [AccountCode], t2.[BusinessProcessInfoID],
		t4.[BusinessModuleInfoID],t5.[DepartmentCode],t6.[Teamid],t7.[UserID] 
	,'AMTeam', CURRENT_TIMESTAMP, 'AMTeam', CURRENT_TIMESTAMP
  FROM [dbo].[P_User_Information]  
  join [dbo].[AccountInfoes]
  on [Account_Name] = [AccountName] and [Account_Type] = [Category]
  join [dbo].[BusinessProcesses] t1
  on [Business_Process] = [BusinessProcessName]
  join [dbo].[BusinessProcessInfoes] t2
  on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] and [AccountInfoID] = t2.[AccountID]
  join [dbo].[BusinessModules] t3
  on [BusinessModuleName] = [Module]
  join [dbo].[BusinessModuleInfoes] t4
  on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] and t4.[BusinessProcessInfoID] = t2.[BusinessProcessInfoID]
  join [dbo].[Departments] t5
  on [Department] = t5.[Name] and t4.[BusinessModuleInfoID] = t5.[BusinessModuleInfoID]
	join [dbo].[Teams] t6 
	on t6.[Name] = team and t6.[DepartmentID] = t5.[DepartmentID]
	join [dbo].[Users] t7
	on t7.[UserName] = [User_Name]
	and not exists( select 1 from [dbo].[UserTeams] t 
					where t6.[TeamID] = t.[TeamID] and t7.[UserID] = t.[UserID]
								and [AccountCode] = t. [AccountCode] 
								and t2.[BusinessProcessInfoID] = t. [BusinessProcessInfoID] 
								and t4.[BusinessModuleInfoID] = t.[BusinessModuleInfoID]
								and t5.[DepartmentCode] = t.[DepartmentCode])		

	--INSERT INTO [dbo].[UserRoles]
	INSERT INTO [dbo].[UserRoles] --564
	(
		[RoleID],
		[UserID],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate]
	)
	select distinct  t4.[RoleID] , t3.[UserID]
			,'AMTeam', CURRENT_TIMESTAMP, 'AMTeam', CURRENT_TIMESTAMP
	FROM [dbo].[P_User_Information]
	join [dbo].[AccountInfoes]
	on [Account_Name] = [AccountName] and [Account_Type] = [Category]
	join [dbo].[Users] t3
	on [User_Name] = t3.[UserName]
	join [dbo].[Roles] t4
	on t4.[AccountID] = [AccountInfoID] and [RoleName] = [Role]
	where not exists (select 1 
						from [dbo].[UserRoles] t 
						where t3.[UserID] = t.[UserID] and t4.[RoleID] = t.[RoleID])

	--INSERT INTO [dbo].[UserPrivileges]
	--DBCC CHECKIDENT ('[dbo].[UserPrivileges]', reseed, 0)
	INSERT INTO [dbo].[UserPrivileges]--115841
	(
		[UserID],
		[AccountCode],
		[Privilege_BusinessModuleInfoID],
		[PrivilegeCode],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate],
		[BusinessModuleCode],[status]
	)
	select 
	distinct  t7.[UserID], t6.[AccountCode], t10.[BusinessModuleInfoID],  t8.[PrivilegeCode]
	,'AMTeam', CURRENT_TIMESTAMP, 'AMTeam', CURRENT_TIMESTAMP,t11.BusinessModuleCode,'ACTIVE'
	FROM [dbo].[P_User_Information]  
	join [dbo].[AccountInfoes] t6
	on [Account_Name] = [AccountName] and [Account_Type] = [Category]
	join [dbo].[Users] t7
	on t7.[UserName] = [User_Name]
	join [dbo].[Roles] t9
	on t9.[AccountID] = t6.[AccountInfoID] and t9.[RoleName] = [Role]
	join [dbo].[RolePrivileges] t10
	on t10.[RoleID] = t9.[RoleID] and t6.[AccountCode] = t10.[AccountCode]
	join [dbo].[Privileges] t8
	on t8.[PrivilegeCode] = t10.[PrivilegeCode]
	join [dbo].[BusinessModules] t11
    on [BusinessModuleName] = [Module]
	where not exists ( select 1 from [UserPrivileges] t where t7.[UserID] = t.[UserID] and t6.[AccountCode] = t.[AccountCode]
								and t10.[BusinessModuleInfoID] = t.[Privilege_BusinessModuleInfoID]
								and t8.[PrivilegeCode] = t.[PrivilegeCode])
								 

	--INSERT INTO select * from [dbo].[WorkGroups]
	INSERT INTO [dbo].[WorkGroups]--2
	(	
		[WorkGroupCode],
		[WorkGroupName],
		[WorkGroupType],
		[AccountCode],
		[BusinessModuleInfoID],
		[UUID],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate]
	)
select 'WG' +REPLICATE('0', 7 - LEN(CONVERT(varchar, RowNumber+1))) + CONVERT(varchar, RowNumber+1)[code], 
	[WorkGroupName], [Work_Group_Name],[AccountCode],[BusinessModuleInfoID],[UUID]
			,'AMTeam', CURRENT_TIMESTAMP, 'AMTeam', CURRENT_TIMESTAMP

	from ( select (SELECT CASE WHEN MAX(convert(int, REPLACE([WorkGroupCode],'WG',''))) is null
							THEN 0
							ELSE (MAX(CONVERT(int, REPLACE([WorkGroupCode],'WG',''))))
							END
					FROM [dbo].[WorkGroups] )
					+ (ROW_NUMBER() OVER (ORDER BY [Work_Group_Name], [BusinessModuleInfoID] )  ) AS RowNumber,
					[WorkGroupName], [Work_Group_Name],[AccountCode], [BusinessModuleInfoID],[UUID]
	from (
	select distinct t6.[First_Name]+'_'+t0.[Work_Group_Name] +'_'
	
	+REPLICATE('0', 3 - LEN(CONVERT(varchar,( select count(*) from [dbo].[WorkGroups] where [WorkGroupName] like t6.[First_Name]+'_'+t0.[Work_Group_Name]+'%' and [AccountCode]=t5.[AccountCode]))))
	  
	+convert(varchar,(select count(*) from [dbo].[WorkGroups] where [WorkGroupName] like t6.[First_Name]+'_'+t0.[Work_Group_Name]+'%'and [AccountCode]=t5.[AccountCode]))
	 [WorkGroupName], t0.[Work_Group_Name],[AccountCode], [BusinessModuleInfoID],[UUID]	
	from [P_User_Mapping] t0
	join [dbo].[BusinessProcesses] t1
	on t1.[BusinessProcessName] = t0.[Business_Process]
	join [dbo].[BusinessProcessInfoes] t2
	on t1.[BusinessProcessCode] = t2.[BusinessProcessCode] 
	join [dbo].[BusinessModules] t3
	on t0.[Module] = t3.[BusinessModuleName]
	join [dbo].[BusinessModuleInfoes] t4
	on t4.[BusinessModuleCode] = t3.[BusinessModuleCode] and t4.[BusinessProcessInfoID] = t2.[BusinessProcessInfoID]
	join [dbo].[AccountInfoes] t5
	on t5.[AccountName] = t0.[Account_Name] and t5.AccountInfoID=t2.AccountID
	join [dbo].[Users] t6
	on t6.[Username] = t0.[Created_By_UserName]	
	where not exists ( select 1 from [dbo].[WorkGroups] t where   t.[WorkGroupType] = t0.[Work_Group_Name]
																and t.[BusinessModuleInfoID] = t4.[BusinessModuleInfoID]
																and t.[AccountCode] = t5.[AccountCode]
																and t.[UUID] = t6.[UUID])
	)temp1
	)temp
	
	




	INSERT INTO [dbo].[UserWorkGroups]--545
	(
		[WorkGroupCode],
		[UUID],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[LastModifiedDate]
	)
	select distinct t4.[WorkGroupCode],
		t5.[UUID]		
			,'AMTeam', CURRENT_TIMESTAMP, 'AMTeam', CURRENT_TIMESTAMP
	from [P_User_Mapping]  t0
	join [dbo].[Users] t1
	on t0.[Created_By_UserName] = t1.[Username]
	join [dbo].[AccountInfoes] t2
	on t0.[Account_Name] = t2.[AccountName]
	join [dbo].[BusinessProcesses] t3
	on t0.[Business_Process] = t3.[BusinessProcessName]
	join [dbo].[WorkGroups] t4
	on 	t4.[UUID] = t1.[UUID] and t4.[WorkGroupType]=t0.[Work_Group_Name] and t4.[AccountCode] = t2.[AccountCode]
	join [dbo].[Users] t5
	on  t0.[UserName] = t5.[Username] or t0.[Created_By_UserName] = t5.[Username]
	where not exists (select 1 from [dbo].[UserWorkGroups] t 
						where [WorkGroupCode]=t4.[WorkGroupCode] and 
						[UUID] = t5.[UUID])





 Insert into [dbo].[AspNetUsers] --481
  (	[ID]
	  ,[UUID]
      ,[Email]
      ,[EmailConfirmed]
      ,[PasswordHash]
      ,[SecurityStamp]
      ,[PhoneNumber]
      ,[PhoneNumberConfirmed]
      ,[TwoFactorEnabled]
      ,[LockoutEndDateUtc]
      ,[LockoutEnabled]
      ,[AccessFailedCount]
      ,[UserName]
  )
  
  select  newid(),
			[UUID],
			USERNAME,
			1,
			'AEB7lrm93MyOYO4qr0r7CgOFzv3ekoTAuqspwoU3hyH+ATiNKwB04ZX/QnebnTX4tg==',
			'0f6f3e3d-2a8f-4242-95fb-84a00ca669e3',
			null,
			1,
			0,
			null,
			1,
			0,
			[UserName]
			from [dbo].[Users] x
			--join [dbo].[UserContactInfo] uc
			--on x.userid=uc.[UserID] --and uc.[ContactType]='EMAIL' and uc.[IsPrimary]=1
			where NOT EXISTS (SELECT 1 FROM [dbo].[AspNetUsers] y
								where [UUID] = x.[UUID] and [UserName]=x.[UserName])




INSERT INTO [dbo].[AccountPreferences] --1 --PK needs to be made identity --0
	(
	 [AccountCode]
      ,[ModuleCode]
	  )

select Distinct  t2.AccountCode,t3.[BusinessModuleCode]
from [P_User_Prefrences] t0
 
join [dbo].[AccountInfoes] t2
on t0.[Account]=t2.[AccountName] and category='LOB'
join [dbo].[BusinessModules] t3
on t0.[Module]=t3.[BusinessModuleName]
where NOT EXISTS (SELECT 1 FROM [dbo].[AccountPreferences] y
								where   y.AccountCode=AccountCode and y.[ModuleCode]=[BusinessModuleCode])


   INSERT INTO [dbo].[UserPreferences] --477
   
  select Distinct   t5.[UserID],t4.[AccountPreferenceID],'Eastern Standard Time'[Time_Zone],1,1
  from [P_User_Prefrences] t0
  join [dbo].[Users] t5
  on t0.[User_Name]=t5.[UserName] 
  join [dbo].[AccountInfoes] t2
  on t0.[Account]=t2.[AccountName]
  join [dbo].[BusinessModules] t3
  on t0.[Module]=t3.[BusinessModuleName]
  join [dbo].[AccountPreferences] t4
  on   t2.AccountCode = t4.AccountCode and t3.[BusinessModuleCode]=t4.[ModuleCode]
  where NOT EXISTS (SELECT 1 FROM [dbo].[UserPreferences] y
								where t5.[UserID] = y.[UserID] )--and y.[AccountPreferenceID]=t4.[AccountPreferenceID] )


END

--old
begin
declare @a int
--SELECT * FROM [Rules_business].[dbo].[User_information_new]
--SELECT * FROM [Rules_business].[dbo].[User_Mapping_UM]
--SELECT * FROM [Rules_business].[dbo].[User_Office_Mapping]
--SELECT * FROM [Rules_business].[dbo].[User_Privileges_new ]

--SELECT * FROM [Rules_business].[dbo].[User_Privileges_new ]




----AccountInfoes
--DECLARE @P_AccountCode nvarchar(100)
--DECLARE @P_AccountName nvarchar(100)
--DECLARE @P_Logo nvarchar(100)
--DECLARE @P_Email nvarchar(100)
--DECLARE @P_FaxNumber nvarchar(100)
--DECLARE @P_PhoneNumber nvarchar(100)
--DECLARE @P_TaxID nvarchar(100)
--DECLARE @P_AddressLine1 nvarchar(100)
--DECLARE @P_AddressLine2 nvarchar(100)
--DECLARE @P_City nvarchar(100)
--DECLARE @P_State nvarchar(100)
--DECLARE @P_ZipCode nvarchar(100)
--DECLARE @P_County nvarchar(100)
--DECLARE @P_Country nvarchar(100)
--DECLARE @P_Category nvarchar(100)
--DECLARE @P_IsPrimary nvarchar(100)
--DECLARE @P_DomainName nvarchar(100)
--DECLARE @P_ParentAccountID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_AccountInfoID bigint

---- TODO: Set parameter values here.


--EXECUTE [dbo].[spInsertAccountInfoes] @P_AccountCode ,@P_AccountName ,@P_Logo ,@P_Email ,@P_FaxNumber ,@P_PhoneNumber ,@P_TaxID 
--,@P_AddressLine1 ,@P_AddressLine2 ,@P_City ,@P_State ,@P_ZipCode ,@P_County ,@P_Country ,@P_Category ,@P_IsPrimary ,@P_DomainName 
--,@P_ParentAccountID ,@P_CreatedBy ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_AccountInfoID OUTPUT



--DECLARE @RC int
--DECLARE @P_BusinessModuleCode nvarchar(100)
--DECLARE @P_ConnectionString nvarchar(100)
--DECLARE @P_BusinessProcessInfoID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_BusinessModuleInfoID bigint


--EXECUTE [dbo].[spInsertBusinessModuleInfoes]   @P_BusinessModuleCode ,@P_ConnectionString ,@P_BusinessProcessInfoID 
-- ,@P_CreatedBy ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_BusinessModuleInfoID OUTPUT









--DECLARE @P_BusinessProcessCode nvarchar(100)
--DECLARE @P_SubscribedDate datetime
--DECLARE @P_AccountID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_BusinessProcessInfoID bigint

--EXECUTE [dbo].[spInsertBusinessProcessInfoes] @P_BusinessProcessCode ,@P_SubscribedDate ,@P_AccountID ,@P_CreatedBy
-- ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_BusinessProcessInfoID OUTPUT



--DECLARE @RC int
--DECLARE @P_DepartmentCode nvarchar(100)
--DECLARE @P_Email nvarchar(100)
--DECLARE @P_Name nvarchar(100)
--DECLARE @P_BusinessModuleInfoID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_DepartmentID bigint

--EXECUTE[dbo].[spInsertDepartments] @P_DepartmentCode ,@P_Email ,@P_Name ,@P_BusinessModuleInfoID ,@P_CreatedBy
-- ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_DepartmentID OUTPUT



--DECLARE @RC int
--DECLARE @P_AddressLine1 nvarchar(100)
--DECLARE @P_AddressLine2 nvarchar(100)
--DECLARE @P_City nvarchar(100)
--DECLARE @P_State nvarchar(100)
--DECLARE @P_ZipCode nvarchar(100)
--DECLARE @P_County nvarchar(100)
--DECLARE @P_Country nvarchar(100)
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_Department_DepartmentID bigint
--DECLARE @P_AddressID bigint

--EXECUTE [dbo].[spInsertOfficeLocations] @P_AddressLine1 ,@P_AddressLine2 ,@P_City ,@P_State ,@P_ZipCode ,@P_County ,@P_Country
-- ,@P_CreatedBy ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_Department_DepartmentID ,@P_AddressID OUTPUT


--DECLARE @RC int
--DECLARE @P_PrivilegeCode nvarchar(100)
--DECLARE @P_PrivilegeName nvarchar(100)
--DECLARE @P_UniqueIdentifier nvarchar(100)
--DECLARE @P_BusinessModuleID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_PrivilegeID bigint

--EXECUTE [dbo].[spInsertPrivileges] @P_PrivilegeCode ,@P_PrivilegeName ,@P_UniqueIdentifier ,@P_BusinessModuleID ,@P_CreatedBy
-- ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_PrivilegeID OUTPUT




--DECLARE @P_WorkGroupName nvarchar(100)
--DECLARE @P_WorkGroupCode nvarchar(100)
--DECLARE @P_WorkGroupType nvarchar(100)
--DECLARE @P_BusinessModuleInfoID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_WorkGroupID bigint


--EXECUTE [dbo].[spInsertWorkGroups] @P_WorkGroupName ,@P_WorkGroupCode ,@P_WorkGroupType ,@P_BusinessModuleInfoID
-- ,@P_CreatedBy ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_WorkGroupID OUTPUT



-- ===============================================================


--DECLARE @RC int
--DECLARE @P_WorkGroupID bigint
--DECLARE @P_AccountCode nvarchar(100)
--DECLARE @P_BusinessModuleInfoID bigint
--DECLARE @P_UserID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_UserWorkGroupID bigint


--EXECUTE @RC = [dbo].[spInsertUserWorkGroups]  @P_WorkGroupID,@P_AccountCode,@P_BusinessModuleInfoID  ,@P_UserID  ,@P_CreatedBy
--,@P_CreatedDate  ,@P_UpdatedBy  ,@P_LastModifiedDate  ,@P_UserWorkGroupID OUTPUT

--============================================================

--DECLARE @RC int
--DECLARE @P_AccountCode nvarchar(100)
--DECLARE @P_BusinessProcessInfoID bigint
--DECLARE @P_BusinessModuleInfoID bigint
--DECLARE @P_DepartmentCode nvarchar(100)
--DECLARE @P_TeamID bigint
--DECLARE @P_UserID nvarchar(100)
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_UserTeamID bigint


--EXECUTE @RC = [dbo].[spInsertUserTeams]  @P_AccountCode,@P_BusinessProcessInfoID,@P_BusinessModuleInfoID,@P_DepartmentCode
--,@P_TeamID,@P_UserID,@P_CreatedBy,@P_CreatedDate,@P_UpdatedBy,@P_LastModifiedDate,@P_UserTeamID OUTPUT


--=======================================

--DECLARE @RC int
--DECLARE @P_UUID nvarchar(100)
--DECLARE @P_First_Name nvarchar(100)
--DECLARE @P_Last_Name nvarchar(100)
--DECLARE @P_Middle_Name nvarchar(100)
--DECLARE @P_Photo nvarchar(100)
--DECLARE @P_Age nvarchar(100)
--DECLARE @P_DOB nvarchar(100)
--DECLARE @P_Phone nvarchar(100)
--DECLARE @P_Email nvarchar(100)
--DECLARE @P_SSN nvarchar(100)
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_UserID bigint

--EXECUTE @RC = [dbo].[spInsertUsers]   @P_UUID ,@P_First_Name ,@P_Last_Name ,@P_Middle_Name ,@P_Photo ,@P_Age ,@P_DOB
-- ,@P_Phone ,@P_Email ,@P_SSN ,@P_CreatedBy ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_UserID OUTPUT

--==========================================================

--DECLARE @RC int
--DECLARE @p_RoleID int
--DECLARE @p_UserID int
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime


--EXECUTE @RC = [dbo].[spInsertUserRoles]    @p_RoleID  ,@p_UserID  ,@P_CreatedBy  ,@P_CreatedDate  ,@P_UpdatedBy
--  ,@P_LastModifiedDate

--  ==================================


--DECLARE @RC int
--DECLARE @P_UserID bigint
--DECLARE @P_AccountCode nvarchar(100)
--DECLARE @P_BusinessProcessInfoID bigint
--DECLARE @P_BusinessModuleInfoID bigint
--DECLARE @P_PrivilegeCode nvarchar(100)
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_UserPrivilegeID bigint

--EXECUTE @RC = [dbo].[spInsertUserPrivileges]  @P_UserID ,@P_AccountCode,@P_BusinessProcessInfoID,@P_BusinessModuleInfoID,@P_PrivilegeCode
--,@P_CreatedBy,@P_CreatedDate,@P_UpdatedBy,@P_LastModifiedDate,@P_UserPrivilegeID OUTPUT

--=================================================


--DECLARE @RC int
--DECLARE @p_AccountID int
--DECLARE @p_UserID int
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime


--EXECUTE @RC = [dbo].[spInsertUserAccounts]    @p_AccountID  ,@p_UserID  ,@P_CreatedBy  ,@P_CreatedDate  ,@P_UpdatedBy
--  ,@P_LastModifiedDate

--================================================================

--DECLARE @RC int
--DECLARE @P_TeamCode nvarchar(100)
--DECLARE @P_Name nvarchar(100)
--DECLARE @P_Email nvarchar(100)
--DECLARE @P_DepartmentID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_TeamID bigint

--EXECUTE @RC = [dbo].[spInsertTeams]    @P_TeamCode  ,@P_Name ,@P_Email  ,@P_DepartmentID  ,@P_CreatedBy  ,@P_CreatedDate
--  ,@P_UpdatedBy  ,@P_LastModifiedDate  ,@P_TeamID OUTPUT

--=======================================================

--DECLARE @RC int
--DECLARE @P_TeamID bigint
--DECLARE @P_UserID nvarchar(100)
--DECLARE @P_AccountCode nvarchar(100)
--DECLARE @P_TeamNodeType nvarchar(100)
--DECLARE @P_ParentOrChildID int
--DECLARE @P_Status nvarchar(100)
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_TeamMappingID bigint


--EXECUTE @RC = [dbo].[spInsertTeamMappings]   @P_TeamID  ,@P_UserID  ,@P_AccountCode  ,@P_TeamNodeType  ,@P_ParentOrChildID
--  ,@P_Status  ,@P_CreatedBy  ,@P_CreatedDate  ,@P_UpdatedBy  ,@P_LastModifiedDate  ,@P_TeamMappingID OUTPUT
--========================


--DECLARE @RC int
--DECLARE @P_RoleCode nvarchar(100)
--DECLARE @P_RoleName nvarchar(100)
--DECLARE @P_Description nvarchar(100)
--DECLARE @P_AccountID bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_RoleID bigint


--EXECUTE @RC = [dbo].[spInsertRoles]    @P_RoleCode  ,@P_RoleName  ,@P_Description  ,@P_AccountID  ,@P_CreatedBy  ,@P_CreatedDate
--  ,@P_UpdatedBy  ,@P_LastModifiedDate  ,@P_RoleID OUTPUT

--==================================================


--DECLARE @RC int
--DECLARE @P_RoleID bigint
--DECLARE @P_AccountCode nvarchar(100)
--DECLARE @P_BusinessProcessInfoID bigint
--DECLARE @P_BusinessModuleInfoID bigint
--DECLARE @P_PrivilegeCode bigint
--DECLARE @P_CreatedBy nvarchar(100)
--DECLARE @P_CreatedDate datetime
--DECLARE @P_UpdatedBy nvarchar(100)
--DECLARE @P_LastModifiedDate datetime
--DECLARE @P_RolePrivilegeID bigint


--EXECUTE @RC = [dbo].[spInsertRolePrivileges]    @P_RoleID  ,@P_AccountCode  ,@P_BusinessProcessInfoID  ,@P_BusinessModuleInfoID  ,@P_PrivilegeCode
--  ,@P_CreatedBy  ,@P_CreatedDate  ,@P_UpdatedBy  ,@P_LastModifiedDate  ,@P_RolePrivilegeID OUTPUT




--DECLARE cursorName1 CURSOR
--	LOCAL SCROLL STATIC
--	FOR
--			SELECT   DISTINCT [Business_Process]
--			FROM [Rules_business].[dbo].[User_Privilege]

--			OPEN cursorName1

--			FETCH NEXT FROM cursorName1 into @INP_Business_Process
--					WHILE @@FETCH_STATUS = 0
--					BEGIN						
--						EXECUTE [dbo].[spInsertBusinessProcesses] @INP_Business_Process,
--																	@P_CreatedBy ,@P_CreatedDate,
--																	@P_UpdatedBy ,@P_LastModifiedDate ,
--																	@P_BusinessProcessID OUTPUT

--						FETCH NEXT FROM cursorName1 into @INP_Business_Process

--					END
--	CLOSE cursorName1
--	DEALLOCATE cursorName1


--DECLARE cursorName2 CURSOR
--LOCAL SCROLL STATIC
--FOR
--		SELECT   distinct [Business_Process], [Modules]
--		FROM [Rules_business].[dbo].[User_Privileges_new]
					
--		OPEN cursorName2
		
--		FETCH NEXT FROM cursorName2 into @INP_Business_Process, @INP_Modules
--		WHILE @@FETCH_STATUS = 0
--		BEGIN			
--			SELECT @P_BusinessProcessID = [BusinessProcessID] 
--			FROM [dbo].[BusinessProcesses]
--			WHERE [BusinessProcessName] = @INP_Business_Process
					
--			EXECUTE [dbo].[spInsertBusinessModules]  @INP_Modules, @P_BusinessProcessID ,@P_CreatedBy
--					 ,@P_CreatedDate ,@P_UpdatedBy ,@P_LastModifiedDate ,@P_BusinessModuleID OUTPUT
					
--			FETCH NEXT FROM cursorName2 into @INP_Business_Process, @INP_Modules		
			
--END
--CLOSE cursorName2
--DEALLOCATE cursorName2
end









