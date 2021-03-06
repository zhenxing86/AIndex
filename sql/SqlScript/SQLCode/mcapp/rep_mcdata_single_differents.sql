USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_single_differents]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：某幼儿园某两日中小朋友的温度对比
--项目名称：rep_mcdata_single_differents
--时间：2013-11-23
--作者：yz
------------------------------------
CREATE PROCEDURE [dbo].[rep_mcdata_single_differents]

@bgndate date,
@enddate date,
@kid int

--exec [mcapp].[dbo].[rep_mcdata_single_differents] '2013-11-14','2013-11-15',20198


 AS 
 BEGIN
 
select d.kid,d.stuid,u.name,d.tw,r.toe,r.ta
  into #t
  from mcapp..stu_mc_day d
  inner join BasicData..[user] u
      on d.stuid = u.userid
  inner join mcapp..stu_mc_day_raw r
      on d.stuid = r.stuid
        and d.cdate = r.cdate
  where d.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and d.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@bgndate),120)
    and d.kid = @kid
    
select d.kid,d.stuid,u.name,d.tw,r.toe,r.ta
  into #p
  from mcapp..stu_mc_day d
  inner join BasicData..[user] u
      on d.stuid = u.userid
  inner join mcapp..stu_mc_day_raw r
      on d.stuid = r.stuid
        and d.cdate = r.cdate
  where d.cdate >= CONVERT(VARCHAR(10),@enddate,120)
    and d.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    and d.kid = @kid
    
select t.kid as kid,
       t.stuid as stuid,
       t.name as 姓名,
       t.tw as 昨日体温,
       t.ta as 昨日ta,
       t.toe as 昨日toe,
       '————'as'————',
       p.tw as 今日体温,
       p.ta as 今日ta,
       p.toe as 今日toe
  from #t t
  inner join  #p p
   on t.stuid = p.stuid
   order by 今日体温 desc
   
drop table #t,#p

end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'同一个人的多天体温横向对比' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_single_differents'
GO
