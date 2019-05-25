USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_hc_test_result_module_GetModel]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xnl
-- alter date: 2014-6-17
-- Description:	根据评测ID获取评测分数实体
-- =============================================
CREATE PROCEDURE [dbo].[hcm_hc_test_result_module_GetModel]
	@testid int
AS
BEGIN
	select moduleid,testid,lowerscore,upperscore,instruction from hc_test_result_module where testid=@testid
END




GO
