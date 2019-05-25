USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_Update]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Procedure [dbo].[hcm_test_Update]
@testid Int,
@version varchar(50),
@testcontent varchar(50),
@instruction varchar(1000),
@weight float,
@age int,
@score float
as
Set nocount on 
Update [hc_test] Set version = @version, testcontent = @testcontent, weight = @weight,instruction=@instruction,age=@age,score=@score Where testid = @testid

if Scope_Identity() > 0
  Select 1
else 
  Select 0
  



GO
