USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_GetModel]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		xnl	
-- ALTER date: 214-6-7
-- Description:	根据ID获取评测模块实体 
-- dome:        exec hcm_test_GetModel 1
-- =============================================
CREATE PROCEDURE [dbo].[hcm_test_GetModel]
	@testid int
AS
BEGIN
	
	SET NOCOUNT ON;
	SELECT testid,version,testcontent,weight,adddate,deletetag,instruction,age,score from dbo.hc_test where testid=@testid 
	
END




GO
