USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_dev_usage_gun]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:yz
-- Create date: 2014-10-21
-- Description:	晨检设备使用情况统计
--[mcapp].[dbo].[rep_mcdata_dev_usage_gun] '2014-10-20','2014-10-24',4
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdata_dev_usage_gun]
	@bgndate date,
	@enddate date,
	@dcnt int
	
AS
BEGIN
	SET NOCOUNT ON;

select distinct r.kid,k.kname 幼儿园名称,r.gunid 晨检枪编号,count(distinct left(CAST(r.cdate as varchar(20)),10))使用天数
 from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
    on r.kid = k.kid
where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
  and r.gunid not in('','00','0')
  and r.kid not in(12511,11061)
group by r.gunid,r.kid,k.kname
 having count(distinct left(CAST(r.cdate as varchar(20)),10)) >= @dcnt
 order by r.kid,r.gunid
 
 END
GO
