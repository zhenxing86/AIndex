USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_choices_GetListByID]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xnl	
-- ALTER date: 2014-05-29
-- Description:	根据问题ID获取答案列表
-- =============================================
CREATE PROCEDURE [dbo].[hcm_test_questions_choices_GetListByID]
	@questionid int
AS
BEGIN
	select choiceid,questionid, choice, weight,titile,content,result from hc_test_questions_choices where questionid=@questionid and deletetag=1 order by orderno asc
END




GO
