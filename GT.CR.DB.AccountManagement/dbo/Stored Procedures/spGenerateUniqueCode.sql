-- =============================================
-- Author:		Greeshma
-- Create date: 12-12-2018
-- Description:	Procedure for handling AccountInfoes data insertions
-- =============================================
CREATE PROCEDURE [dbo].[spGenerateUniqueCode] 
       @prefix nvarchar(50),
       @TableName  nvarchar(100),
       @ColumnName nvarchar(100),
       @UniqueCode nvarchar(50) out
AS
BEGIN
       
   SET NOCOUNT ON;

   DECLARE @Select NVARCHAR(4000)
   DECLARE @Max_MDM_Code int
   DECLARE @Char_Code NVARCHAR(50),@Unique_MDM_Code NVARCHAR(100),@Pre_MDM_Code NVARCHAR(100);

   set @Select =N'select @Max_MDM_Code=max(replace('+@ColumnName+',@prefix,'''')) from '+@TableName;
   print 'COlumn Name: '+convert(varchar,@ColumnName);
         
       print @Select
       EXEC SP_EXECUTESQL @Select
       ,N'@prefix nvarchar(50) ,@Max_MDM_Code int out ',
       @prefix=@prefix ,@Max_MDM_Code = @Max_MDM_Code OUTPUT;
              
       print 'Max Code:'+ convert(varchar,@Max_MDM_Code);
         if(@Max_MDM_Code is null)
           set @Max_MDM_Code=1
         else                      
          set @Max_MDM_Code=@Max_MDM_Code+1
		            
          set @Char_Code=cast(@Max_MDM_Code  as nvarchar(50))                                                  
          set @Unique_MDM_Code=concat(@prefix,convert(varchar,REPLICATE('0',7 - len(@Char_Code))) ,@Char_Code)
          set @UniqueCode=@Unique_MDM_Code;    
           --select @Unique_MDM_Code;

END







