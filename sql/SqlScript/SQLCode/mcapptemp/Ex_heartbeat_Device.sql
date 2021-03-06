USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[Ex_heartbeat_Device]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-09
-- Description:	心跳异常设备一览表
-- Memo:		
Ex_heartbeat_Device -1,-1,-1,'',-1

*/
CREATE PROC [dbo].[Ex_heartbeat_Device]
	@provinceid int, 
	@cityid int, 
	@areaid int, 
	@kname varchar(50), 
	@kid int
AS
BEGIN  
 SET NOCOUNT ON  
 DECLARE @flag int  
 CREATE TABLE #kid(kid int)  
 CREATE TABLE #ta(devid varchar(9), kid int, adate datetime, rowno int)  
    
  EXEC @flag = CommonFun.DBO.Filter_Kid @provinceid,@cityid,@areaid,@kname,@kid  
    
 IF @flag = -1    
 BEGIN  
  insert into #ta(devid,kid,adate)    
   select devid, d.kid, getdate() as adate   
    from driveinfo d   
   union    
   select devid, d.kid, convert(varchar(10),getdate(),120) + ' 06:00:00'   
    from driveinfo d    
  INSERT INTO #ta(devid,kid,adate)   
   select devid,kid,adate  
    from runstatus     
    where adate >= convert(varchar(10),getdate(),120)   
 END  
 ELSE  
 BEGIN   
  insert into #ta(devid,kid,adate)    
   select devid, d.kid, getdate() as adate   
    from driveinfo d   
     inner join #kid k on d.kid = k.kid  
   union all     
   select devid, d.kid, convert(varchar(10),getdate(),120) + ' 06:00:00'   
    from driveinfo d   
     inner join #kid k on d.kid = k.kid       
  INSERT INTO #ta(devid,kid,adate)   
   select devid,r.kid,adate  
    from runstatus r   
     inner join #kid k on r.kid = k.kid    
    where adate >= convert(varchar(10),getdate(),120)    
 END    
  
 ;with cet as    
 (    
  select *, row_number()over(partition by devid order by adate) rowno1    
  from #ta    
 )    
 update cet     
  set rowno = rowno1    
    
 select a.kid, CAST(NULL AS VARCHAR(50))kname, a.devid, SUM(datediff(ss,a.adate,b.adate)/300) unusualcnt,     
     CommonFun.dbo.sp_getsumstr(RIGHT(convert(varchar(19),a.adate,120),8)     
     + '~' + RIGHT(convert(varchar(19),b.adate,120),8) + ', ') unusualtime  
 INTO #RESULT    
  from #ta a     
   inner join #ta b on a.devid = b.devid   
           and a.rowno = b.rowno - 1    
  where datediff(ss,a.adate,b.adate) > 310    
  group by a.kid, a.devid    
   
 update r set kname = k.kname   
  from #RESULT r   
   inner join BasicData.dbo.kindergarten k on r.kid = k.kid  
  
 select * from #RESULT  
  order by unusualcnt desc  
   
 drop table #ta,#RESULT,#kid   
END  

GO
