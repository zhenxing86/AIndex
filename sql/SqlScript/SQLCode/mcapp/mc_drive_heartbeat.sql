USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_drive_heartbeat]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-02
-- Description:	监控晨检设备心跳
-- Memo:		
*/
CREATE PROC [dbo].[mc_drive_heartbeat]
AS
BEGIN
	SET NOCOUNT ON	
	 
	select devid,kid,adate,cast(null as int)rowno 
		into #ta 
		from runstatus 
		where adate >= convert(varchar(10),getdate(),120)

	insert into #ta(devid,kid,adate)
		select devid, kid, getdate() as adate from driveinfo
			union
		select devid, kid, convert(varchar(10),getdate(),120) + ' 06:00:00' from driveinfo

	;with cet as
	(
		select *, row_number()over(partition by devid order by adate) rowno1
			from #ta
	)
	update cet 
		set rowno = rowno1

	select	a.kid,a.devid,SUM(datediff(ss,a.adate,b.adate)/300) 心跳异常, 
					CommonFun.dbo.sp_getsumstr(RIGHT(convert(varchar(19),a.adate,120),8) 
						+ '~' + RIGHT(convert(varchar(19),b.adate,120),8) + ', ') 异常时间段
		from #ta a 
			inner join #ta b 
				on a.devid = b.devid 
			and a.rowno = b.rowno - 1
		where datediff(ss,a.adate,b.adate) > 330
		group by a.kid, a.devid

drop table #ta
			
END

GO
