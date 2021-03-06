USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_single_detail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：
--项目名称：
--时间：2013-11-23
--作者：yz
------------------ ------------------

CREATE PROCEDURE [dbo].[rep_mcdata_single_detail]

@bgndate date,
@enddate date,
@kid int
--exec [mcapp].[dbo].[rep_mcdata_single_detail] '2014-03-27','2014-03-27',21307

 AS 
 BEGIN
 
select r.kid as kid,
       k.kname as 幼儿园名称,
       u.userid as stuid,
       c.cname as 班级名称,
       u.name as 学生姓名,
       r.cdate as 测温时间,
       d.sms_zz as 短信症状,
       d.sms_tw as 短信tw,
       d.zz as 症状,
       r.tw as tw,
       r.ta as ta,
       r.toe as toe,
       r.devid as 设备编号,
       r.gunid as 枪编号
       
  from mcapp..stu_mc_day_raw r
    inner join mcapp..stu_mc_day d
      on r.card = d.card and r.cdate = d.cdate
    inner join BasicData..kindergarten k
      on r.kid = k.kid
    inner join cardinfo ci
      on r.[card]=ci.[card]
    inner join BasicData..[User] u
      on ci.userid = u.userid
    inner join BasicData..user_class uc
      on uc.userid = u.userid
    inner join BasicData..class c
      on uc.cid = c.cid
      
  where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    --and CAST(r.ta as numeric(6,2))>= 14
    --and CAST(r.ta as numeric(6,2))<= 15
    and r.kid = @kid
    --and u.name = '王潇冉'
   --and r.stuid = 8248
    --and r.gunid = '08'
    
    
  order by r.tw  desc
  
  end
  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单个幼儿园晨检数据细节' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_single_detail'
GO
