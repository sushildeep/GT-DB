-- =============================================
-- Author:		<Hemanth>
-- Create date: <5/9/2017>
-- Description:	<Adding User Module Mapping>
-- =============================================
CREATE Procedure [dbo].[SPCreateUserModuleMapping]
(
@UUID varchar(10),
@AccountCode varchar(10),
@ModuleCode varchar(10),
@Createdby varchar(50),
@Remarks varchar(200) =null out
) as
begin

begin try
--insert into [dbo].[UserAccountMappings]
		SELECT AccountInfoID,userid,@Createdby,getdate(),null,null,BusinessModuleInfoId,'ACTIVE',0
		  FROM [AccountManagementV3.0_Dev].[dbo].[BusinessModuleInfoes] bm
		  join [dbo].[BusinessProcessInfoes] bp on bp.[BusinessProcessInfoID]=bm.[BusinessProcessInfoID]
							  and [BusinessModuleCode]=@ModuleCode
		  join [dbo].[AccountInfoes] ac on accountcode=@AccountCode and bp.AccountID=ac.AccountInfoID 
		  join  users u on u.UUID=@UUID
	end try
begin catch
		set @Remarks=concat((select top 1 remarks from users where uuid=@UUID),'Failed to Create Module Mapping')
		update users set @Remarks=@Remarks where uuid=@UUID
		end catch
		select @Remarks
end

/*
declare @R varchar(50)
Exec SPCreateUserModuleMapping 'UU0000001','LOB000001','bm0000001','abc',@R out
select @R 
*/

