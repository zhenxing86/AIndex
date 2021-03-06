USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_dev_usage_bykid_test]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:yz
-- Create date: 2014-10-21
-- Description:	幼儿园使用晨检设备情况统计
--[mcapp].[dbo].[rep_mcdata_dev_usage_bykid_test] '2014-10-10','2014-11-10',4
-- =============================================
create PROCEDURE [dbo].[rep_mcdata_dev_usage_bykid_test]
	@bgndate date,
	@enddate date,
	@dcnt int
	
AS
BEGIN
	SET NOCOUNT ON;

create table #result(kid int,kname varchar(50),guncnt int,padcnt int,dev1cnt int,dev2cnt int)


select distinct r.kid,k.kname,r.gunid
 into #t1
 from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
    on r.kid = k.kid
where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
  and r.gunid not in('','00','0')
  and r.kid not in(12511,11061)
group by r.gunid,r.kid,k.kname
 having count(distinct left(CAST(r.cdate as varchar(20)),10)) >= @dcnt
 
 select distinct r.kid,
       k.kname,
       r.devid,
       case when cast(right(devid,2)as int)between 1 and 10 then '一体机'
            when cast(right(devid,2)as int) = 30 then '二代机' 
            else '平板'end dtype
  into #t2
  from mcapp..stu_mc_day_raw r
  inner join BasicData..kindergarten k
    on r.kid = k.kid
where r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
    and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
  and r.kid not in(12511,11061)
  and cast(right(devid,2)as int) <> 0
group by r.devid,r.kid,k.kname
 having count(distinct left(CAST(r.cdate as varchar(20)),10)) >= @dcnt


 insert into #result (kid,kname) 
 select distinct kid,kname from #t1
 UNION 
 select distinct kid,kname from #t2
 
   
 select kid,kname,COUNT(gunid) guncnt into #gun from #t1 group by kid,kname  
 select kid,kname,COUNT(devid) padcnt into #pad from #t2 where dtype = '平板'  group by kid,kname  
 select kid,kname,COUNT(devid) dev1cnt into #dev1 from #t2 where dtype = '一体机'  group by kid,kname  
 select kid,kname,COUNT(devid) dev2cnt into #dev2 from #t2 where dtype = '二代机'  group by kid,kname  
   
 
 update r
  set r.guncnt = gun.guncnt
  from #result r
    inner join #gun gun
      on r.kid = gun.kid
      
  update r
  set r.padcnt = pad.padcnt
  from #result r
    inner join #pad pad
      on r.kid = pad.kid
      
  update r
  set r.dev1cnt = dev1.dev1cnt
  from #result r
    inner join #dev1 dev1
      on r.kid = dev1.kid
      
  update r
  set r.dev1cnt = dev2.dev2cnt
  from #result r
    inner join #dev2 dev2
      on r.kid = dev2.kid

      
  update #result set guncnt = 0 where ISNULL(guncnt,0)= 0
  update #result set padcnt = 0 where ISNULL(padcnt,0)= 0
  update #result set dev1cnt = 0 where ISNULL(dev1cnt,0)= 0
  update #result set dev2cnt = 0 where ISNULL(dev2cnt,0)= 0
    
    
 select * from #result order by guncnt desc,padcnt desc,dev1cnt  desc
    
  drop table #result,#t1,#t2,#gun,#pad,#dev1,#dev2
 
 END
GO
