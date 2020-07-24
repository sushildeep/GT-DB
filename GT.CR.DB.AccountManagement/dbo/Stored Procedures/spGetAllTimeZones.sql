-- =============================================
-- Author:		Nitesh Suresh
-- ALTER date: 27/12/2016
-- Description:	Get All Timezones
-- =============================================
CREATE Procedure [dbo].[spGetAllTimeZones] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [TimeZoneUTC],[TimeZoneDTxt] FROM [TimeCodes]
END













