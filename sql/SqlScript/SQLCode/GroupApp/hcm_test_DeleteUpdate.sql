USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_DeleteUpdate]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create Procedure [dbo].[hcm_test_DeleteUpdate]
@id Int,
@deletetag int
as
Set nocount on 
Update [hc_test] Set deletetag = @deletetag Where testid = @id

if Scope_Identity() > 0
  Select 1
else 
  Select 0
  





GO
