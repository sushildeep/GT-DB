-- =============================================
-- Author:		Greeshma
-- Create date: 12-12-2018
-- Description:	Procedure for handling AccountInfoes data insertions
-- =============================================
CREATE Procedure [dbo].[spInsert_Master_AccountInfoes]
	--@P_AccountCode nvarchar(100)=NULL,
	@P_AccountName nvarchar(100),
	@p_ParentAccountCode nvarchar(100)=null,
	@P_Logo nvarchar(100)=NULL,
	@P_Email nvarchar(100)=NULL,	
	@P_IsPrimary nvarchar(100)=NULL,
	@P_DomainName nvarchar(100)=NULL,
	@P_ParentAccountID bigint=NULL,
	--@P_CreatedBy nvarchar(100)=NULL,
	--@P_UpdatedBy nvarchar(100)=NULL,
	@P_AccountAbbrevation nvarchar(10),
	@P_AccountCode nvarchar(100)=NULL
	--@P_AccountInfoID bigint OUT
AS
BEGIN

	SET NOCOUNT ON;

	declare @AccountCode varchar(100),@Parent_AcId int
	 DECLARE @Max_Code int
   DECLARE @Char_Code NVARCHAR(50),@Unique_Code NVARCHAR(100),@Pre_MDM_Code NVARCHAR(100);

	--select * from [dbo].[AccountInfoes]

	If not exists(select 1 from [AccountInfoes] where ISNULL([AccountName],'12311231') = ISNULL(@P_AccountName,'12311231') )
	BEGIN

	----- Generating Unique LOB Code
		select @Max_Code=max(replace([AccountCode],'LOB','')) from AccountInfoes where [AccountCode] like '%LOB%';
		if(@Max_Code is null)
           set @Max_Code=1
         else                      
          set @Max_Code=@Max_Code+1
		            
          set @Char_Code=cast(@Max_Code  as nvarchar(50))                                                  
          set @Unique_Code=concat('LOB',convert(varchar,REPLICATE('0',6 - len(@Char_Code))) ,@Char_Code)
          set @AccountCode=@Unique_Code;   
	--===================================

		 if(@p_ParentAccountCode is null)
		 begin
		 


		 -- Generating Unique AC Code
		 	select @Max_Code=max(replace([AccountCode],'AC','')) from AccountInfoes where [AccountCode] like '%AC%';
		 	if(@Max_Code is null)
		        set @Max_Code=1
		      else                      
		       set @Max_Code=@Max_Code+1
		 	            
		       set @Char_Code=cast(@Max_Code  as nvarchar(50))                                                  
		       set @Unique_Code=concat('AC',convert(varchar,REPLICATE('0',7 - len(@Char_Code))) ,@Char_Code)
		       set @p_ParentAccountCode=@Unique_Code; 
		 	  ---=================================================================
		 
		 	   insert into [AccountInfoes]
			    ([AccountCode], [AccountName], [Logo], [Email], [Category], [DomainName], [ParentAccountID], [CreatedBy], [CreatedDate])
		 	   select @p_ParentAccountCode ,  @P_AccountName, @P_Logo, @P_Email, 'ORG', @P_DomainName, 0, 'AMTeam', getdate()
			   
			   select @Parent_AcId=SCOPE_IDENTITY();

		 end
		 else
		 begin
			
			select @Parent_AcId=AccountInfoID from [AccountInfoes]
			where [AccountCode]=@p_ParentAccountCode;


		 end
		 
	   	  insert into [AccountInfoes] 
		  ([AccountCode], [AccountName], [Logo], [Email], [Category],  [DomainName], [ParentAccountID], [CreatedBy], [CreatedDate])
		  select @AccountCode ,@P_AccountName, @P_Logo, @P_Email, 'LOB',  @P_DomainName, @Parent_AcId, 'AMTeam', getdate()

	end
	else
	begin

	    select @AccountCode=[AccountCode] from [AccountInfoes] where ISNULL([AccountName],'12311231') = ISNULL(@P_AccountName,'12311231')
		print 'An Account already exists with same name , Having AccountCode as '+@AccountCode;

	end




	select @AccountCode;
END








