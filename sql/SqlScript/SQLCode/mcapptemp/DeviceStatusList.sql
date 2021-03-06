USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[DeviceStatusList]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
exec DeviceStatusList -1,-1,-1,'',12511

*/
CREATE PROC [dbo].[DeviceStatusList]
	@provinceid int, 
	@cityid int, 
	@areaid int, 
	@kname varchar(50), 
	@kid int
AS
BEGIN	
	SET NOCOUNT ON
	CREATE TABLE #kid(kid int)
	CREATE TABLE #devid(devid varchar(9), kid int)
	CREATE TABLE #ta(devid varchar(9), kid int, adate datetime, rowno int)
  DECLARE @flag int
  EXEC @flag = CommonFun.DBO.Filter_Kid @provinceid,@cityid,@areaid,@kname,@kid
  
	IF @flag = -1 
	BEGIN
		INSERT INTO #devid(devid, kid)  
			select devid, kid
				from driveinfo 
				
		INSERT INTO #ta(devid,kid,adate)	
			select devid,kid,adate
				from runstatus   
				where adate >= DATEADD(SS,-1800,GETDATE())
	END
	ELSE
	BEGIN
		INSERT INTO #devid(devid, kid)  
			select devid, d.kid
				from driveinfo d 
					inner join #kid k on d.kid = k.kid		
								
		INSERT INTO #ta(devid,kid,adate)	
			select devid,r.kid,adate
				from runstatus r 
					inner join #kid k on r.kid = k.kid  
				where adate >= DATEADD(SS,-1800,GETDATE())  
	END		
	SELECT d.kid, CAST(NULL AS VARCHAR(50))kname, d.devid, oa1.heartbeatcnt, oa2.lastheartbeattime
		INTO #RESULT
		FROM #devid d 
			outer apply(select COUNT(1) heartbeatcnt from #ta t where d.devid = t.devid)oa1
			outer apply(select top(1) r.adate lastheartbeattime from runstatus r where d.devid = r.devid order by r.adate desc)oa2
			
	update r set kname = k.kname 
		from #RESULT r 
			inner join BasicData.dbo.kindergarten k on r.kid = k.kid

	select * from #RESULT
		ORDER BY #RESULT.lastheartbeattime desc 
	
END

GO
