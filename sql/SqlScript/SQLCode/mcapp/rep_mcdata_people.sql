USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_people]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz
-- Create date: 2014-4-4
-- Description:	查询某三天的幼儿园晨检人数变化情况
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_people]
@date date
AS
BEGIN
	SET NOCOUNT ON 
	select r.kid,k.kname,COUNT(r.tw)as 今日晨检人数
  into #t
  from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
      on r.kid = k.kid
   where r.cdate >= CONVERT(VARCHAR(10),@date,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@date),120)
   group by  r.kid,k.kname
  
select r.kid,k.kname,COUNT(r.tw)as 昨日晨检人数
  into #p
  from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
      on r.kid = k.kid
   where r.cdate >= CONVERT(VARCHAR(10),DATEADD(DD,-1,@date),120)
    and r.cdate < CONVERT(VARCHAR(10),@date,120)
   group by  r.kid,k.kname
  
select r.kid,k.kname,COUNT(r.tw)as 前日晨检人数
  into #q
  from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
      on r.kid = k.kid
   where r.cdate >= CONVERT(VARCHAR(10),DATEADD(DD,-2,@date),120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,-1,@date),120)
   group by  r.kid,k.kname
  
select t.kid,t.kname,前日晨检人数,昨日晨检人数,今日晨检人数,昨日晨检人数-今日晨检人数 as 今日减少
  from #t t
  inner join #p p
    on t.kid = p.kid
  inner join #q q
    on t.kid = q.kid
    order by 今日减少 desc
    
   drop table #t,#p,#q

END

GO
