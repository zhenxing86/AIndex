USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_gun_offline_dataup]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-6-20
-- Description:	晨检枪频繁出现离线数据上传
--[dbo].[mm_gun_offline_dataup] 1,100,'2014-06-19'
-- =============================================
CREATE PROCEDURE [dbo].[mm_gun_offline_dataup]
  @page int,
  @size int,
  @date date

AS
BEGIN
	SET NOCOUNT ON;
	
	select l.kid,
	       k.kname,
         count(case when l.logmsg like '%传输了离线晨检数据%' then l.logid else null end) as offlinecnt,
         u.name,
         i.finfofrom
    into #t
    from mcapp..LogInfo l
      inner join BasicData..kindergarten k
        on l.kid = k.kid
      left join BlogApp..permissionsetting p
      on k.kid = p.kid

      left join ossapp..kinbaseinfo i
        on l.kid = i.kid
      left join ossapp..[Users] u
        on i.developer = u.id
        
    where l.logtime  >= CONVERT(VARCHAR(10),@date,120)
      and l.logtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
      and l.kid not in (12511,11061,22018,22030,22053,21935,22084)
      and p.ptype = 90
    group by l.kid,k.kname,u.name,i.finfofrom
    having count(case when l.logmsg like '%传输了离线晨检数据%' then l.logid else null end) >= 3
    
  
  
 exec sp_MutiGridViewByPager    
  @fromstring = '#t',      --数据集    
  @selectstring =     
  'kid,kname,offlinecnt,name,finfofrom',      --查询字段    
  @returnstring =     
  'kid,kname,offlinecnt,name,finfofrom',      --返回字段    
  @pageSize = @Size,                 --每页记录数    
  @pageNo = @page,                     --当前页    
  @orderString = 'offlinecnt desc,name',          --排序条件    
  @IsRecordTotal = 1,             --是否输出总记录条数    
  @IsRowNo = 0          --是否输出行号    

drop table #t 
END

GO
