/*        
-- Author:      Master谭        
-- Create date: 2013-07-09        
-- Description: 心跳异常设备一览表        
-- Memo:          
mcapp..Ex_heartbeat_Device -1,-1,-1,'',-1        
mcapp..Ex_heartbeat_Device '','','','',-1,135,0,-1      
*/        
alter PROC Ex_heartbeat_Device     
 @provinceid varchar(100),          
 @cityid varchar(100),          
 @areaid varchar(100),           
 @kname varchar(50),         
 @kid int,            
 @cuid int=0,           
 @developer varchar(100)='',       
 @devicetype int =-1          
AS        
BEGIN          
 SET NOCOUNT ON          
 DECLARE @flag int          
 CREATE TABLE #kid(kid int)          
 CREATE TABLE #ta(devid varchar(9), kid int, adate datetime, rowno int,devicetype int)          
            
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,@provinceid,@cityid,@areaid,@cuid,@developer           
            
 IF @flag = -1            
 BEGIN          
  insert into #ta(devid,kid,adate,devicetype)            
   select devid, d.kid, getdate() as adate,devicetype          
    from driveinfo d       
    where d.deletetag=1 and devicetype =(case when @devicetype=-1 then devicetype else  @devicetype end)           
   union            
   select devid, d.kid, convert(varchar(10),getdate(),120) + ' 06:00:00',devicetype           
    from driveinfo d        
    where d.deletetag=1 and devicetype =(case when @devicetype=-1 then devicetype else  @devicetype end)           
  INSERT INTO #ta(devid,kid,adate,devicetype)           
   select r.devid,r.kid,adate,devicetype         
    from runstatus r       
     inner join driveinfo d on d.deletetag=1 and r.devid=d.devid and d.devicetype =(case when @devicetype=-1 then d.devicetype else  @devicetype end)             
    where adate >= convert(varchar(10),getdate(),120)           
 END          
 ELSE          
 BEGIN           
  insert into #ta(devid,kid,adate,devicetype)            
   select devid, d.kid, getdate() as adate,devicetype           
    from driveinfo d           
     inner join #kid k on d.kid = k.kid        
     where d.deletetag=1 and devicetype =(case when @devicetype=-1 then devicetype else  @devicetype end)            
   union all             
   select devid, d.kid, convert(varchar(10),getdate(),120) + ' 06:00:00',devicetype           
    from driveinfo d           
     inner join #kid k on d.deletetag=1 and d.kid = k.kid        
     where devicetype =(case when @devicetype=-1 then devicetype else  @devicetype end)                 
  INSERT INTO #ta(devid,kid,adate,devicetype)           
   select r.devid,r.kid,adate,devicetype          
    from runstatus r           
     inner join #kid k on r.kid = k.kid        
     inner join driveinfo d on d.deletetag=1 and r.devid=d.devid and d.devicetype =(case when @devicetype=-1 then d.devicetype else  @devicetype end)             
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
     + '~' + RIGHT(convert(varchar(19),b.adate,120),8) + ', ') unusualtime,a.devicetype          
 INTO #RESULT            
  from #ta a             
   inner join #ta b on a.devid = b.devid           
           and a.rowno = b.rowno - 1            
  where datediff(ss,a.adate,b.adate) > 310            
  group by a.kid, a.devid,a.devicetype            
           
 update r set kname = k.kname           
  from #RESULT r           
   inner join BasicData.dbo.kindergarten k on r.kid = k.kid          
          
 select * from #RESULT          
  order by unusualcnt desc          
           
 drop table #ta,#RESULT,#kid           
END          