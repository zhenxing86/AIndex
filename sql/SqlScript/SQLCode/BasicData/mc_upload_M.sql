USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[mc_upload_M]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*              
-- Author:      Master谭              
-- Create date:               
-- Description:               
-- Memo:                
mc_upload_M 1,1000,'','','','',0,'2014-6-19',1,''              
              
*/              
CREATE PROC [dbo].[mc_upload_M]       
 @page int,      
 @size int,             
 @provinceid varchar(100),              
 @cityid varchar(100),              
 @areaid varchar(100),                
 @kname varchar(50),               
 @kid int,              
 @date datetime,            
 @cuid int=0,               
 @developer varchar(100)=''             
AS              
BEGIN              
 SET NOCOUNT ON              
 CREATE TABLE #result(kid int, kname varchar(50), Totalcnt int, uploadcnt int)               
 CREATE TABLE #kid(kid int)              
  DECLARE @flag int              
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,@provinceid,@cityid,@areaid,@cuid,@developer             
                
 IF @flag = -1               
 BEGIN              
  INSERT INTO #result(kid, uploadcnt)               
  SELECT kid, count(DISTINCT stuid)                
   from stu_at_all_V               
   WHERE cdate >= CONVERT(VARCHAR(10),@date,120)              
    and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)              
   group by kid               
 END              
 ELSE              
 BEGIN                   
  INSERT INTO #result(kid, uploadcnt)               
  SELECT sm.kid, count(DISTINCT stuid)                
   from stu_at_all_V sm              
    inner join #kid k on sm.kid = k.kid               
   WHERE sm.cdate >= CONVERT(VARCHAR(10),@date,120)              
    and sm.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)               
   group by sm.kid                  
 END               
                 
 update #result set Totalcnt = kc.Totalcnt, kname = k.kname                
  from #result r               
   inner join BasicData.dbo.ChildCnt_ForKid kc               
    on r.kid = kc.kid              
   inner join BasicData.dbo.kindergarten k              
    on r.kid = k.kid              
                  
 select kid,kname,Totalcnt,  uploadcnt,CAST(1.0*uploadcnt/totalcnt as numeric(9,4)) uploadrate     
  into #t            
  from #result              
  ORDER BY uploadrate     
   
         
       
  --分页查询                  
 exec sp_MutiGridViewByPager                  
  @fromstring = '#t ',      --数据集                  
  @selectstring =                   
  ' kid, kname, Totalcnt, uploadcnt,uploadrate',      --查询字段                  
  @returnstring =                   
  ' kid, kname, Totalcnt, uploadcnt,uploadrate',      --返回字段                  
  @pageSize = @Size,                 --每页记录数                  
  @pageNo = @page,                     --当前页                  
  @orderString = ' uploadrate ',          --排序条件                  
  @IsRecordTotal = 1,             --是否输出总记录条数                  
  @IsRowNo = 0          --是否输出行号        
  
drop table #t  
END   
  
  
  
  
  
GO
