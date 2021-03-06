USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_Update]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Procedure [dbo].[hcm_test_questions_Update]
@questionid Int,
@testid int,
@moduleid int,
@orderno int, 
@title varchar(100),
@frequency varchar(500),
@instruction varchar(max), 
@regulation varchar(max),
@choosetype varchar(10),
@weight float
as
Set nocount on 

Update hc_test_questions Set testid = @testid, moduleid = @moduleid, orderno = @orderno, title = @title, 
                             frequency = @frequency, instruction = @instruction, regulation = @regulation, 
                             choosetype = @choosetype, weight = @weight
  Where questionid = @questionid

if Scope_Identity() > 0
  Select 1
else 
  Select 0
  





GO
