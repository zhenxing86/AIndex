USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[PayDetail_Query_GetCount]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------

------------------------------------
CREATE PROCEDURE [dbo].[PayDetail_Query_GetCount]
@time_star datetime,
@time_end datetime,
@status int--1支付成功,0 待支付状态
 AS 
	DECLARE @TempID int
	/*
	SELECT
         @TempID=count(1) from payapp..order_record where actiondatetime between @time_star and @time_end and status=@status	
	RETURN @TempID	
*/

SELECT
         @TempID=count(1) from payappdemo..order_record where actiondatetime between @time_star and @time_end and status=@status	
	RETURN @TempID		













GO
