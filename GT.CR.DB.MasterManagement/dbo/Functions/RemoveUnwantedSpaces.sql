CREATE  Function  [dbo].[RemoveUnwantedSpaces]
(@MyString as varchar(Max))
Returns varchar(Max)
As
Begin
			--What if <> or >< are already present in DATA
	if(@MyString not like '%<>%' and @MyString not like '%><%')
	begin
		--NULL
		--Set @MyString = Replace(@MyString,CHAR(0),' ');
		--Horizontal Tab
		Set @MyString = Replace(@MyString,CHAR(9),' ');
		--Line Feed
		Set @MyString = Replace(@MyString,CHAR(10),' ');
		--Vertical Tab
		Set @MyString = Replace(@MyString,CHAR(11),' ');
		--Form Feed
		Set @MyString = Replace(@MyString,CHAR(12),' ');
		--Carriage Return
		Set @MyString = Replace(@MyString,CHAR(13),' ');
		--Column Break
		Set @MyString = Replace(@MyString,CHAR(14),' ');
		--Non-breaking space
		Set @MyString = Replace(@MyString,CHAR(160),' ');
		--replace more spaces with one space
		Set @MyString = replace(replace(replace(@MyString,' ','<>'),'><',''),'<>',' ')

	end

	Set @MyString = LTRIM(RTRIM(@MyString));

	if(@MyString='') set @MyString=null

	Return @MyString
End


--select 'string_r3' , replace(replace(replace(' select   single       spaces',' ','  '),' ',''),'<>',' ')


--<>select<><><>single spaces
--select 'Actual' data,' select   single       spaces' Data
--union
--select 'string_r1' , replace(' select   single       spaces',' ','<>')
--union
--select 'string_r2' , replace(replace(' select   single       spaces',' ','<>'),'><','')
--union
--select 'string_r3' , replace(replace(replace(' select   single       spaces',' ','<>'),'><',''),'<>',' ')

--select [dbo].[CleanAndTrimString] 
--(' a	b
--c '),' a	b
--c '


--select Replace('*space'+CHAR(0)+'******space*',CHAR(0),' ')--,'*space'+CHAR(0)+'******space*'
--union select '*Horizontal Tab'+CHAR(9)+'Horizontal Tab*'
--union select '*Line Feed'+CHAR(10)+'Line Feed*'
--union select '*Vertical Tab'+CHAR(11)+'Vertical Tab*'
--union select '*Form Feed'+CHAR(12)+'Form Feed*'
--union select '*Carriage Return'+CHAR(13)+'Carriage Return*'
--union select '*Column Break'+CHAR(14)+'Column Break*'
--union select '*Non-breaking space'+CHAR(160)+'Non-breaking space*'
--'*Horizontal Tab	
--Horizontal Tab*'
--	*Horizontal Tab	Horizontal Tab*
--	*Column BreakColumn Break*
--	*Carriage Return
--Carriage Return*
----*Form FeedForm Feed*
--select Replace('*space'+CHAR(0)+'******space*',CHAR(0),' '),'*space'+CHAR(0)+'******space*',Replace('*space',CHAR(0),' ')

--/****** Object:  UserDefinedFunction [dbo].[CleanAndTrimString]    Script Date: 03-03-2017 18:12:01 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--Alter Function  [dbo].[Get_ASCII_Values] 
--(@colString as varchar(Max))
--Returns varchar(Max)
--As
--Begin


--DECLARE @counter int = 1;
--DECLARE @colString varchar(10) = ' a	b
--c ';
--SELECT null [Character],null [ASCIIValue],null [fromStatus] into #Char_Ascii



--SELECT null [Character],null [ASCIIValue],null [fromStatus] into #Char_Ascii

--WHILE @counter <= DATALENGTH(@colString)
--   BEGIN
--   insert into ##Char_Ascii
--	SELECT CHAR(ASCII(SUBSTRING(@colString, @counter, 1))) as [Character],
--	ASCII(SUBSTRING(@colString, @counter, 1)) as [ASCIIValue],'Actual' [fromStatus]
--	SET @counter = @counter + 1
--   END


--SELECT null [Character],null [ASCIIValue] into ##Char_Ascii

--WHILE @counter <= DATALENGTH(@colString)
--   BEGIN
--   insert into ##Char_Ascii
--	SELECT CHAR(ASCII(SUBSTRING(@colString, @counter, 1))) as [Character],
--	ASCII(SUBSTRING(@colString, @counter, 1)) as [ASCIIValue]
--	SET @counter = @counter + 1
--   END
--GO