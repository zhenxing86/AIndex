USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_xy_analysis]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：XY参数分析用
--项目名称：rep_mcdata_xy_analysis
--时间：2013-11-23
--作者：yz
------------------------------------
CREATE PROCEDURE [dbo].[rep_mcdata_xy_analysis]

@bgndate date,
@enddate date,
@kid int,
@b numeric(6,2),
@x1 numeric(6,2),
@x2 numeric(6,2),
@y1 numeric(6,2),
@y2 numeric(6,2)

--exec [mcapp].[dbo].[rep_mcdata_xy_analysis] '2013-11-04','2013-11-05',20145,0.12, 0.9,0.6,36.5,37.8

 AS 
 BEGIN

select r.kid as kid,
       k.kname as 幼儿园名称,
       r.stuid as stuid,
       c.cname as 班级名称,
       u.name as 学生姓名,
       r.cdate as 测温时间,
       r.tw as 显示体温,
       -0.000125*POWER((25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2))),6)
       +0.0283429488*POWER((25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2))),5)
       -2.67004808*POWER((25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2))),4)
       +133.762569*POWER((25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2))),3)
       -3758.41829*POWER((25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2))),2)
       +56155.4892*(25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2)))
       -348548.755
       +(25*@b+0.7 - @b * cast(r.ta as numeric(6,2)) + cast(r.toe as numeric(6,2))) as a,
       r.ta as ta,
       r.toe as toe,
       r.devid as 设备编号,
       r.gunid as 枪编号
       
  into #t
       
       
  from mcapp..stu_mc_day_raw r
    inner join BasicData..kindergarten k
      on r.kid = k.kid
    inner join BasicData..[user] u
      on r.stuid = u.userid  --select * from  BasicData..[user]
    inner join BasicData..user_class uc
      on uc.userid = u.userid
    inner join BasicData..class c
      on uc.cid = c.cid
      
  where r.kid = @kid
    and r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    
  order by 显示体温 desc 
  
  
 select 显示体温,
        a as 修正体温,
        case when a <= @y1 then a+@x1*(@y1-a) when a >= @y2 then a+@x2*(@y2-a) else a end as 修正体温2,
        ta,
        toe
        
   from #t
   
   order by 显示体温 desc
   
 drop table #t
 
	END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线性回归测试' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_xy_analysis'
GO
