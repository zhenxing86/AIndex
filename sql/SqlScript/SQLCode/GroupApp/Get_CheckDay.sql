USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[Get_CheckDay]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-16
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[Get_CheckDay]
	@bid int
as
BEGIN
	SET NOCOUNT ON
	declare @userid int, @term varchar(6), @kid int, @bgndate datetime, @enddate datetime
	
	select	@userid = uid, 
					@term = term, 
					@kid = kid 
		from HealthApp.DBO.BaseInfo 
		where ID = @bid
		
	SELECT	@bgndate = bgndate, 
					@enddate = enddate 
		FROM CommonFun.[dbo].getTerm_bgn_endByTerm(@term,@kid)  
		
	select CheckDate
		into #T
		from mcapp..stu_mc_day 
		where stuid = @userid
			and CheckDate >= @bgndate 
			and CheckDate < @enddate
		ORDER BY CheckDate
		
	select CONVERT(VARCHAR(7),fm.StartT,120)cmonth, day(t.CheckDate)cdate 
		from CommonFun.dbo.fn_MonthList(1,0) fm
			left join #T t 
				on CONVERT(VARCHAR(7),t.CheckDate,120) = CONVERT(VARCHAR(7),fm.StartT,120)
		where StartT >= @bgndate 
			and StartT <  @enddate

	DROP TABLE #T
END

GO
