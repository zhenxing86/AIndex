USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Procedure [dbo].[hcm_test_GetList]
as
Set nocount on 

Select moduleid, modulename, orderno 
  From hc_test_module 
  Where deletetag = 1 
  Order by orderno

Select testid, version, testcontent, weight,deletetag 
  From [hc_test] 
  Where deletetag >= 1 
  Order by version

Select questionid, testid, moduleid, orderno, title, frequency, instruction, regulation, choosetype, weight
  From hc_test_questions 
  Where deletetag = 1

Select choiceid, questionid, choice, weight 
  From hc_test_questions_choices 
  Where deletetag = 1 







GO
