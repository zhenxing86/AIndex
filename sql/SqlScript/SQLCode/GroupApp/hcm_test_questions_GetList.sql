USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[hcm_test_questions_GetList]
	@testid int
AS
BEGIN
	select questionid, q.testid, moduleid, orderno, title, frequency, t.instruction, regulation, choosetype, q.weight,t.testcontent from hc_test t,hc_test_questions q where t.testid=q.testid and t.testid=@testid and q.deletetag=1 order by orderno asc
END



GO
