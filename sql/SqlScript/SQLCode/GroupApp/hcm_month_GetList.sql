USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_month_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[hcm_month_GetList]
	@userid int,
	@indate datetime
AS
BEGIN
	
	SET NOCOUNT ON;
	select '37' tw,1 chuqin,'3,7' statedesc
	
	select n,CAST(FLOOR(RAND()*N) AS INT)%2 from CommonFun.dbo.Nums1Q where n<31
	
END





GO
