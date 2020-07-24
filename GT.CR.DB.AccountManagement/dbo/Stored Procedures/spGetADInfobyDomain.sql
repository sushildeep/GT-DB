-- =============================================
-- Author:		<Rakesh>
-- Create date: <12/06/2017>
-- Description:	<GetADInfobyDomain>
-- =============================================
CREATE PROCEDURE [dbo].[spGetADInfobyDomain]
	-- Add the parameters for the stored procedure here
@domain nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT [Url],[Remarks],[DomainIP],[DomainUserName],[DomainUserPassword] FROM [DomainADInfo] WHERE [Domain]=@domain
END

--exec [spGetADInfobyDomain] 'AHCP'


