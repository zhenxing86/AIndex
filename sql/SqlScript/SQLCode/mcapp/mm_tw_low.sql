USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_tw_low]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-6-20
-- Description:	温度异常低的幼儿园
--[dbo].[mm_tw_low] 1,10,'2014-6-19', '2014-6-19'
-- =============================================
create PROCEDURE [dbo].[mm_tw_low]
@page int,
@size int,
@bgndate date, --默认当天        
@enddate date --默认当天   
      
        
AS        
BEGIN        
 SET NOCOUNT ON;        
       
    
   select r.kid,
          k.kname as kname,        
          cast(1.0 * COUNT(case when cast(tw as numeric(6,2)) <= 36.4 then tw else null end)        
                / COUNT(tw)as numeric(5,3))as proportion,
          COUNT(tw) cnt,
          COUNT(case when cast(tw as numeric(6,2)) <= 36.4 then tw else null end) lcnt,
          u.name,
          i.finfofrom
      into #t
     from mcapp..stu_mc_day r         
       inner join BasicData..kindergarten k       
         on r.kid = k.kid   
         left join ossapp..kinbaseinfo i
        on k.kid = i.kid
    left join ossapp..[Users] u
        on i.developer = u.id    
   
     where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
       and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)      
       and ISNUMERIC(r.tw)=1
       and cast(tw as numeric(6,2))<> 0
    
      group by r.kid,k.kname,u.name,i.finfofrom
      having cast(1.0 * COUNT(case when cast(tw as numeric(6,2)) <= 36.4  then tw else null end)        
    / COUNT(tw)as numeric(5,3)) >= 0.5
          
  exec sp_MutiGridViewByPager                    
  @fromstring = '#t ',      --数据集                    
  @selectstring =                     
  'kid,kname,proportion,cnt,lcnt,name,finfofrom',      --查询字段                    
  @returnstring =                     
  'kid,kname,proportion,cnt,lcnt,name,finfofrom',      --返回字段                    
  @pageSize = @Size,                 --每页记录数                    
  @pageNo = @page,                     --当前页                    
  @orderString = 'proportion desc,name',          --排序条件                    
  @IsRecordTotal = 1,             --是否输出总记录条数                    
  @IsRowNo = 0          --是否输出行号       
          
          
   drop table #t

END

GO
