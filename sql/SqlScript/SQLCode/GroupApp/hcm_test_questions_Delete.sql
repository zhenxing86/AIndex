USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hcm_test_questions_Delete]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Procedure [dbo].[hcm_test_questions_Delete]
@questionid Int
as
Set nocount on 

Update hc_test_questions Set deletetag = 0 Where questionid = @questionid






GO
