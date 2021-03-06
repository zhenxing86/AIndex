/*                        
-- Author:      Master谭                        
-- Create date:                         
-- Description:    mcapp                     
-- Memo:                          
exec DeviceStatusList 1,10,-1,'','','','',141,'',-1                      
select *from mcapp..driveinfo where devicetype is  null               
select * from ossapp..users where name='硬件合作厂商' where id=141                   
*/                        
alter PROC [dbo].[DeviceStatusList]                         
 @page int,              
 @size int,                      
 @kid int,                        
 @kname varchar(100),                        
 @provinceid varchar(100),                        
 @cityid varchar(100),                        
 @areaid varchar(100),                          
 @cuid int=0,                         
 @developer varchar(100)='',                     
 @devicetype int =-1 ,    
 @seeself int=0 --针对客服可以选择看自己跟进还是看所有幼儿园                      
AS                        
BEGIN                         
 SET NOCOUNT ON                        
 CREATE TABLE #kid(kid int)                        
 CREATE TABLE #devid(devid varchar(50), kid int,devicetype int )                        
 CREATE TABLE #ta(devid varchar(50), kid int, adate datetime, rowno int)                        
  DECLARE @flag int                        
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,@provinceid,@cityid,@areaid,@cuid,@developer,@seeself                       
                          
 IF @flag = -1                        
 BEGIN                        
  INSERT INTO #devid(devid, kid,devicetype)                          
   select devid, kid,devicetype                       
    from driveinfo                     
    where deletetag=1 and devicetype =(case when @devicetype=-1 then devicetype else  @devicetype end)                     
      and devicetype <>(case when @cuid=157 then 2 else  99 end)               
                            
  INSERT INTO #ta(devid,kid,adate)                         
   select devid,kid,adate                        
    from runstatus                           
    where adate >= DATEADD(SS,-1800,GETDATE())                        
 END                        
 ELSE                        
 BEGIN                        
  INSERT INTO #devid(devid, kid,devicetype)                          
   select devid, d.kid,devicetype                       
    from driveinfo d                         
     inner join #kid k on d.kid = k.kid                        
     where deletetag=1 and devicetype =(case when @devicetype=-1 then devicetype else  @devicetype end)                       
       and devicetype <>(case when @cuid=157 then 2 else  99 end)               
                                 
  INSERT INTO #ta(devid,kid,adate)                         
   select devid,r.kid,adate                        
    from runstatus r                         
     inner join #kid k on r.kid = k.kid                          
    where adate >= DATEADD(SS,-1800,GETDATE())                          
 END                          
 SELECT d.kid, CAST(NULL AS VARCHAR(500))kname, d.devid, oa1.heartbeatcnt, oa2.lastheartbeattime,devicetype                       
  INTO #RESULT                        
  FROM #devid d                         
   outer apply(select COUNT(1) heartbeatcnt from #ta t where d.devid = t.devid)oa1                        
   outer apply(select top(1) r.adate lastheartbeattime from runstatus r where d.devid = r.devid order by r.adate desc)oa2                        
                           
 update r set kname = k.kname                         
  from #RESULT r                         
   inner join BasicData.dbo.kindergarten k on r.kid = k.kid                        
                        
 --select kid, kname, devid, heartbeatcnt, lastheartbeattime,devicetype                
 -- from #RESULT                        
 --  ORDER BY #RESULT.lastheartbeattime desc                         
              
 --分页查询                      
 exec sp_MutiGridViewByPager                      
  @fromstring = '#RESULT',      --数据集                      
  @selectstring =                       
  ' kid, kname, devid, heartbeatcnt, lastheartbeattime,devicetype',      --查询字段                      
  @returnstring =                       
  ' kid, kname, devid, heartbeatcnt, lastheartbeattime,devicetype',      --返回字段                      
  @pageSize = @Size,                 --每页记录数                      
  @pageNo = @page,                     --当前页                      
  @orderString = ' lastheartbeattime desc ',          --排序条件         
  @IsRecordTotal = 1,             --是否输出总记录条数                      
  @IsRowNo = 0          --是否输出行号                      
                 
END   
  