USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[PayStat_GetCount]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------

------------------------------------
create PROCEDURE [dbo].[PayStat_GetCount]

 AS 
	DECLARE @TempID int
	/*
	SELECT
         @TempID=count(1) from payapp..order_record where actiondatetime between @time_star and @time_end and status=@status	
	RETURN @TempID	
*/

SELECT
         @TempID=count(1) from t_paystat
	RETURN @TempID		














GO
