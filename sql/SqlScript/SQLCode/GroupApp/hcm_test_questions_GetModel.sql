USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_GetModel]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		xnl	
-- ALTER date: 2014-05-28
-- Description:	获取问题实体
-- =============================================
CREATE PROCEDURE  [dbo].[hcm_test_questions_GetModel]
	@questionid int
AS
BEGIN
	select * from hc_test_questions where questionid=@questionid
END





GO
