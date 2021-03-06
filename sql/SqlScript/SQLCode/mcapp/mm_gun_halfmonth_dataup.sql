USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_gun_halfmonth_dataup]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	yz
-- Create date: 2014-6-20
-- Description:	晨检枪最近半个月都没有上传数据的幼儿园
--[dbo].[mm_gun_halfmonth_dataup] 1,200
-- =============================================
CREATE PROCEDURE [dbo].[mm_gun_halfmonth_dataup]

@page int,
@size int

AS
BEGIN
	SET NOCOUNT ON;
  
  select d.kid,k.kname,d.gunnum,u.name,i.finfofrom
    into #t
  from mcapp..tcf_setting d
    left join BasicData..kindergarten k
      on d.kid = k.kid
    left join BlogApp..permissionsetting p
      on d.kid = p.kid
    left join ossapp..kinbaseinfo i
      on d.kid = i.kid
  left join ossapp..[Users] u
      on i.developer = u.id  
  
  where d.gunnum not in (select distinct gunnum
                         from mcapp..stu_mc_day_raw  r
                         where r.cdate >= CONVERT(VARCHAR(10),DATEADD(DD,-15,GETDATE()),120)
                           and r.kid = d.kid)
    and d.kid not in (12511,11061,22018,22030,22053,21935,22084)    
    and p.ptype = 90 
    

 exec sp_MutiGridViewByPager    
  @fromstring = '#t',      --数据集    
  @selectstring =     
  'kid,kname,gunnum,name,finfofrom',      --查询字段    
  @returnstring =     
  'kid,kname,gunnum,name,finfofrom',      --返回字段    
  @pageSize = @Size,                 --每页记录数    
  @pageNo = @page,                     --当前页    
  @orderString = 'name,kid,gunnum',          --排序条件    
  @IsRecordTotal = 1,             --是否输出总记录条数    
  @IsRowNo = 0        --是否输出行号    
         
    
drop table #t    
END

GO
