USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_result_module_GetList]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[hcm_test_result_module_GetList]
@testid int
as
Set nocount on 

Select moduleid, testid, lowerscore, upperscore, instruction From hc_test_result_module Where testid=@testid and deletetag = 1 order by moduleid
  




GO
