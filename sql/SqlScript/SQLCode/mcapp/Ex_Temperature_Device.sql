USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[Ex_Temperature_Device]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date:         
-- Description:         
-- Memo:          
Ex_Temperature_Device 1,10,'','','','',-1,'2013-09-05','2013-09-05',1,''        
        
*/        
CREATE PROC [dbo].[Ex_Temperature_Device]  
 @page int,  
 @size int,       
 @provinceid varchar(100),          
 @cityid varchar(100),          
 @areaid varchar(100),          
 @kname varchar(50),         
 @kid int,        
 @bgndate datetime,         
 @enddate datetime,      
 @cuid int=0,           
 @developer varchar(100)=''        
AS        
BEGIN        
 SET NOCOUNT ON         
 CREATE TABLE #T(kid int, cdate datetime, tw numeric(5,1), devid varchar(50), gunid varchar(50))        
 CREATE TABLE #kid(kid int)        
  DECLARE @flag int        
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,@provinceid,@cityid,@areaid,@cuid,@developer         
          
 IF @flag = -1         
 BEGIN        
   INSERT INTO #T(cdate, tw, devid, gunid)         
   SELECT sm.cdate, sm.tw, sm.devid, sm.gunid        
    from stu_mc_day sm        
     inner join BasicData..User_Child uc        
      on sm.stuid = uc.userid        
    WHERE sm.Status = 0        
     and sm.CheckDate >= @bgndate        
     and sm.CheckDate <= @enddate        
     AND sm.tw <> 0          
 END        
 ELSE        
 BEGIN          
   INSERT INTO #T(cdate, tw, devid, gunid)         
   SELECT sm.cdate, sm.tw, sm.devid, sm.gunid        
    from stu_mc_day sm        
     inner join BasicData.dbo.User_Child u on sm.stuid = u.userid        
     inner join #kid k on sm.kid = k.kid        
    WHERE sm.Status = 0        
     and sm.CheckDate >= @bgndate        
     and sm.CheckDate <= @enddate        
     AND sm.tw <> 0         
 END        
         
 select CAST(NULL AS int) AS kid, CAST(NULL AS VARCHAR(50)) AS kname, devid, gunid,         
     COUNT(case when tw > 38 THEN 1 ELSE NULL END)Highcnt,         
     COUNT(case when tw < 35 THEN 1 ELSE NULL END)Lowcnt        
  INTO #RESULT          
  from #T        
  WHERE devid is not null        
  GROUP BY devid, gunid          
         
 UPDATE r set kid = k.kid, kname = k.kname         
  FROM #RESULT r         
   inner join driveinfo d        
    on r.devid = d.devid        
   inner join BasicData.dbo.kindergarten k        
    on d.kid = k.kid        
         
 --select * from #RESULT        
 -- ORDER BY devid, gunid     
    
    --分页查询              
 exec sp_MutiGridViewByPager              
  @fromstring = '#RESULT',      --数据集              
  @selectstring =               
  ' kid, kname, devid, gunid, Highcnt, Lowcnt ',      --查询字段              
  @returnstring =               
  ' kid, kname, devid, gunid, Highcnt, Lowcnt ',      --返回字段              
  @pageSize = @Size,                 --每页记录数              
  @pageNo = @page,                     --当前页              
  @orderString = ' devid, gunid  ',          --排序条件              
  @IsRecordTotal = 1,             --是否输出总记录条数              
  @IsRowNo = 0      
         
END 
GO
