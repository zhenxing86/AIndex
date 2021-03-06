USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_dev_usage_pad]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:yz
-- Create date: 2014-10-21
-- Description:	晨检设备使用情况统计
--[mcapp].[dbo].[rep_mcdata_dev_usage_pad]'2014-11-3','2014-11-6',4
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_dev_usage_pad]
	@bgndate date,
	@enddate date,
	@dcnt int
	
AS
BEGIN
	SET NOCOUNT ON;

select distinct r.kid,
       k.kname 幼儿园名称,
       r.devid 设备编号,
       count(distinct left(CAST(r.cdate as varchar(20)),10))使用天数,
       case when cast(right(devid,2)as int)between 1 and 10 then '一体机'when cast(right(devid,2)as int) = 30 then '二代机' else '平板'end 设备类型
 from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
    on r.kid = k.kid
where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
  and r.kid not in(12511,11061)
  and cast(right(devid,2)as int) <> 0
group by r.devid,r.kid,k.kname
 having count(distinct left(CAST(r.cdate as varchar(20)),10)) >= @dcnt
 order by 设备类型,r.kid,r.devid
 
 END
GO
