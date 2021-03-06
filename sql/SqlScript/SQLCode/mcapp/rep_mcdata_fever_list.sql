USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_fever_list]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：在更新了晨检枪的幼儿园中获取发烧的小朋友详细信息(默认取当天)
--项目名称：rep_mc_fever_list
--时间：2014-11-20
--作者：yz
------------------------------------
CREATE PROCEDURE [dbo].[rep_mcdata_fever_list]
 @bgndate date, 
 @enddate date
--exec [mcapp].[dbo].[rep_mcdata_fever_list] '2014-11-18','2014-11-20'

 AS 
   BEGIN
	 select r.kid as kid,
       k.kname as 幼儿园名称,
       us.name as 跟进人,
       r.stuid as stuid,
       u.name as 学生姓名,
       r.cdate as 测温时间,
       r.tw as 显示体温,
       r.ta as ta,
       r.toe as toe,
       r.devid as 设备编号,
       r.gunid as 枪编号
       
  from mcapp..stu_mc_day_raw r
    inner join mcapp..stu_mc_day d
      on r.[card] = d.[card] and r.cdate = d.cdate
    inner join BasicData..kindergarten k
      on r.kid = k.kid
    inner join ossapp..kinbaseinfo kb
      on k.kid = kb.kid
    left join ossapp..[Users] us
      on kb.developer = us.id
    inner join cardinfo c
      on r.[card]=c.[card]
    inner join BasicData..[user] u
      on c.userid = u.userid
      
  where r.tw >= '37.8'
    and r.kid not in (12511,11061)
    and r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    
  order by r.kid
  END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'总体发烧数据统计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_fever_list'
GO
