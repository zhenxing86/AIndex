USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_mc_at_low]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author:  yz  
-- Create date: 2014-6-20  
-- Description: 出勤率偏低的幼儿园  
--[mcapp].[dbo].[mm_mc_at_low]1,100,'2014-6-19'  
-- =============================================  
CREATE PROCEDURE [dbo].[mm_mc_at_low]  
 @page int,        
 @size int,          
 @date date           
  
AS  
BEGIN  
 SET NOCOUNT ON;  
 CREATE TABLE #result(kid int, kname varchar(50), Totalcnt int, uploadcnt int)                 
  CREATE TABLE #kid(kid int)                
             
  INSERT INTO #result(kid, uploadcnt)                 
  SELECT kid, count(DISTINCT stuid)                  
   from stu_at_all_V     
               
   WHERE cdate >= CONVERT(VARCHAR(10),@date,120)                
    and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)  
    and kid not in (12511,11061,22018,22030,22053,21935,22084)              
   group by kid                 
             
                   
 update #result set Totalcnt = kc.Totalcnt, kname = k.kname                  
  from #result r                 
   inner join BasicData.dbo.ChildCnt_ForKid kc                 
    on r.kid = kc.kid                
   inner join BasicData.dbo.kindergarten k                
    on r.kid = k.kid       
           
                    
 select r.kid,r.kname,r.Totalcnt,  r.uploadcnt,100*CAST(1.0*r.uploadcnt/r.totalcnt as numeric(9,4)) uploadrate,u.name name,i.finfofrom   
  into #t              
  from #result r
  left join ossapp..kinbaseinfo i
      on r.kid = i.kid
  left join ossapp..[Users] u
      on i.developer = u.id             
  ORDER BY uploadrate       
     
           
         
  --分页查询                    
 exec sp_MutiGridViewByPager                    
  @fromstring = '#t ',      --数据集                    
  @selectstring =                     
  ' kid, kname, Totalcnt, uploadcnt,uploadrate,name,finfofrom',      --查询字段                    
  @returnstring =                     
  ' kid, kname, Totalcnt, uploadcnt,uploadrate,name,finfofrom',      --返回字段                    
  @pageSize = @Size,                 --每页记录数                    
  @pageNo = @page,                     --当前页                    
  @orderString = ' uploadrate,name',          --排序条件                    
  @IsRecordTotal = 1,             --是否输出总记录条数                    
  @IsRowNo = 0          --是否输出行号          
    
drop table #t    
  
END  
GO
