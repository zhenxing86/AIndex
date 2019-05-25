USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_result_module_Edit]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		xnl
-- alter date: 2014-6-16
-- Description:	编辑评测分数模版表
-- =============================================
CREATE PROCEDURE [dbo].[hcm_test_result_module_Edit]
@moduleid int,
	@lowerscore float,
	@upperscore float,
	@instruction varchar(max)
AS
BEGIN
	UPDATE [healthapp].[dbo].[hc_test_result_module]
   SET 
      lowerscore = @lowerscore
      ,upperscore = @upperscore
      ,instruction = @instruction
     
 WHERE moduleid=@moduleid

END




GO
