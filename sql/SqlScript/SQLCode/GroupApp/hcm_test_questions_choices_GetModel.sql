USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_choices_GetModel]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xnl	
-- ALTER date: 2014-05-30
-- Description:	根据ID获取实体
-- =============================================
CREATE PROCEDURE [dbo].[hcm_test_questions_choices_GetModel]
	@choiceid int
AS
BEGIN
	select choiceid, questionid, choice, weight,titile,content,result from hc_test_questions_choices where choiceid=@choiceid 
END




GO
