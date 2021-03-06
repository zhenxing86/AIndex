USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_class_checked_sum_year_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-19
-- Description:	
-- Memo:		
*/ 
CREATE PROCEDURE [dbo].[rep_mc_class_checked_sum_year_GetList]
	@kid int,
	@checktime1 datetime,
	@checktime2 datetime
AS 
BEGIN
	SET NOCOUNT ON 
	
	create table #temp
	(
		tid int IDENTITY(1,1) NOT NULL,
		tctime varchar(100)
	)
	--初始化一共查询本年的哪几个月的信息

	while(@checktime1 <= @checktime2)
	begin
		insert into #temp(tctime) values (convert(varchar(10),@checktime1,120))

		set @checktime1 = DATEADD(MM,1,@checktime1)
	end 

	select 	tctime, SUM(totalcount), SUM(exceptionsum), sum(realcount), 
					sum(notcome), SUM(parentstake), SUM(fs), SUM(hlfy), SUM(ks),
					SUM(lbt), SUM(fx), SUM(hy), SUM(szk), SUM(pz), SUM(fytx), SUM(jzj)
		from #temp t
			left join dbo.rep_mc_class_checked_sum r 
				on year(t.tctime) = year(r.cdate) 
				and month(t.tctime) = month(r.cdate)
				and kid = @kid
				AND gid <> 38
		group by tid, tctime
		order by tid
		
	drop table #temp
END

GO
