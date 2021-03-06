USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_mc_at_unusual]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-6-20
-- Description:	入离园比例有异常的幼儿园
--[dbo].[mm_mc_at_unusual] 1,200,'2014-6-19'
-- =============================================
CREATE PROCEDURE [dbo].[mm_mc_at_unusual]
@page int    
,@size int
,@DATE DATE

AS
BEGIN
	SET NOCOUNT ON;
	
	select kid,
       COUNT(ID) as c1
 into #t1
from mcapp..stu_mc_day_raw
where adate >= CONVERT(VARCHAR(10),@date,120)
  and adate< DATEADD(HH,12,CONVERT(VARCHAR(10),@date,120))
GROUP BY kid

select kid,
       COUNT(ID) as c2
 into #t2
from mcapp..stu_mc_day_raw
where adate >= DATEADD(HH,12,CONVERT(VARCHAR(10),@date,120))
  and adate < DATEADD(HH,24,CONVERT(VARCHAR(10),@date,120))
GROUP BY kid

select (case when ISNULL(t1.c1,0)=0 then t2.kid else t1.kid end)kid,
       k.kname,t1.c1 am,t2.c2 pm,CAST(1.0*t1.c1/t2.c2 as numeric(9,4)) proportion,u.name,i.finfofrom
       into #t
  from #t1 t1
    full join #t2 t2
      on t1.kid = t2.kid
    left join BasicData..kindergarten k
      on (t1.kid = k.kid) or(t2.kid = k.kid)
    left join BlogApp..permissionsetting p
      on k.kid = p.kid
    left join ossapp..kinbaseinfo i
        on k.kid = i.kid
    left join ossapp..[Users] u
        on i.developer = u.id
    where k.kid not in (12511,11061,22018,22030,22053,21935,22084)
      and p.ptype = 90

 
  exec sp_MutiGridViewByPager                    
  @fromstring = '#t ',      --数据集                    
  @selectstring =                     
  'kid,kname,am,pm,proportion,name,finfofrom',      --查询字段                    
  @returnstring =                     
  ' kid,kname,am,pm,proportion,name,finfofrom',      --返回字段                    
  @pageSize = @Size,                 --每页记录数                    
  @pageNo = @page,                     --当前页                    
  @orderString = 'proportion,pm,am,name',          --排序条件                    
  @IsRecordTotal = 1,             --是否输出总记录条数                    
  @IsRowNo = 0          --是否输出行号  
      
 drop table #t1,#t2,#t

END

GO
