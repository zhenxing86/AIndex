USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_distributed]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：晨检温度分布（百分比）
--项目名称：rep_mcdata_distributed
--时间：2013-11-23
--作者：yz
------------------------------------

CREATE PROCEDURE [dbo].[rep_mcdata_distributed]

@bgndate date,
@enddate date
--exec [mcapp].[dbo].[rep_mcdata_distributed] '2014-1-1', '2014-4-1'

AS 
BEGIN

select r.kid as kid,
       k.kname as 幼儿园名称,
       COUNT(r.tw)as 总人数,
       cast(1.0 * COUNT(case when cast(r.tw as numeric(6,2))<36.3 then r.tw else null end)
          / COUNT(r.tw)as numeric(5,3) )as '小于36.3',
       cast(1.0 * COUNT(case when cast(r.tw as numeric(6,2))>=36.3 and cast(r.tw as numeric(6,2)) < 36.8 then r.tw else null end) 
          / COUNT(r.tw)as numeric(5,3))as '36.3 ~ 36.8',
       cast(1.0 * COUNT(case when cast(r.tw as numeric(6,2))>=36.8 and cast(r.tw as numeric(6,2)) < 37.3 then r.tw else null end) 
          / COUNT(r.tw)as numeric(5,3))as '36.8 ~ 37.3',
       cast(1.0 * COUNT(case when cast(r.tw as numeric(6,2))>=37.3 and cast(r.tw as numeric(6,2)) < 37.8 then r.tw else null end) 
          / COUNT(r.tw)as numeric(5,3))as '37.3 ~ 37.8',
       cast(1.0 * COUNT(case when cast(r.tw as numeric(6,2))>=37.8 then r.tw else null end) 
          / COUNT(r.tw)as numeric(5,3))as '大于37.8'
          
  from mcapp..stu_mc_day_raw r
    inner join BasicData..kindergarten k
      on r.kid = k.kid
    inner join mcapp..stu_mc_day d
      on r.[card] = d.[card] and r.cdate = d.cdate
  
 where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
    and ISNUMERIC(r.tw)=1
    and ISNUMERIC(r.ta)=1
    and CAST(r.ta as numeric(6,2))>0
    and CAST(r.tw as numeric(6,2))>0
    --and r.kid = @kid
    
    group by r.kid,k.kname

end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'温度分布统计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_distributed'
GO
