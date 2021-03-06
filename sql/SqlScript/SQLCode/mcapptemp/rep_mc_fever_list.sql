USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_fever_list]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：在更新了晨检枪的幼儿园中获取发烧的小朋友详细信息(默认取当天)
--项目名称：rep_mc_fever_list
--时间：2013-10-14
--作者：yz
------------------------------------
CREATE PROCEDURE [dbo].[rep_mc_fever_list]
 @bgndate date, 
 @enddate date

 AS 
   BEGIN
	 select r.kid as kid,
       k.kname as 幼儿园名称,
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
      on r.stuid = d.stuid and r.cdate = d.cdate
    inner join BasicData..kindergarten k
      on r.kid = k.kid
    inner join BasicData..[user] u
      on r.stuid = u.userid
      
  where r.tw > '37.8'
    and r.kid in (select distinct kid
			            from mcapp..gun_para_xg 
			            where [Status] = 2)
    and r.kid <> 12511
    and r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    
  order by r.kid
  END

GO
