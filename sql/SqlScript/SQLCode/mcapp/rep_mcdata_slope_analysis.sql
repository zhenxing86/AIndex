USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_slope_analysis]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_mcdata_slope_analysis]
 @bgndate date,
 @enddate date
AS
-- rep_mcdata_slope_analysis '2014-10-1','2014-11-20' 

select AVG(cast(r.toe as float))as a
  INTO #t
 from mcapp..stu_mc_day_raw r
 where ISNUMERIC(r.toe)=1 and ISNUMERIC(r.ta)= 1
   and cast(r.toe as numeric(6,2))> 30
   and r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
   and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
   and cast(r.ta as float) between 11 and 13
   
 select AVG(cast(r.toe as float))as a
  INTO #p
  
 from mcapp..stu_mc_day_raw r
 where ISNUMERIC(r.toe)=1and ISNUMERIC(r.ta)= 1
   and cast(r.toe as numeric(6,2))> 30
   and r.cdate >= CONVERT(VARCHAR(10),@bgndate,120)
   and r.cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
   and cast(r.ta as float) between 18 and 20
   
   select (t.a - p.a)/7
     from #t t
       inner join #p p
         on 1=1
   
   drop table #t,#p
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'测温数值随气温变化的线性回归斜率测试用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_mcdata_slope_analysis'
GO
