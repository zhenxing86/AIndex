USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_result_module_Delete]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE Procedure [dbo].[hcm_test_result_module_Delete]
@moduleid int
as
Set nocount on 

Update hc_test_result_module Set deletetag = 0 Where moduleid = @moduleid

if Scope_Identity() > 0
  Select 1
else 
  Select 0
  




GO
