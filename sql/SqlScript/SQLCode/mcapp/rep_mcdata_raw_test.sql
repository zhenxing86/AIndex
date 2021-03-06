USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdata_raw_test]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------- ---    
--用途：    
--项目名称：    
--时间：2014-8-4  
--作者：yz    
-- [dbo].[rep_mcdata_raw_test] '2014-11-1','2014-11-21',	20569
------------------ ------------------    
    
CREATE PROCEDURE [dbo].[rep_mcdata_raw_test]    
    
@bgndate date,    
@enddate date,    
@kid int  
    
AS     
BEGIN    
     
select kid,    
       card,    
       cdate,    
       adate,    
       tw,    
       ta,    
       zz,    
       toe,    
       devid,     
       gunid,  
       (5.7 - 0.2 * cast(ta as float) + cast(toe as float))as toe1  
  into #t                                   
  from mcapp..stu_mc_day_raw   
       
  where isnumeric(toe)=1  
    and isnumeric(ta)=1  
    and cdate >= CONVERT(VARCHAR(10),@bgndate,120)    
    and cdate < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)    
    --and kid = @kid    
      
      
      
    -------------------------------------------------  
  
select kid,    
       card,    
       cdate,    
       adate,    
       tw,    
       ta,    
       zz,    
       toe,    
       devid,     
       gunid,  
       toe1,  
       case when toe1 <= 35.3 then toe1+ 0.8 *(35.3-toe1) else toe1 end as toe2  
       into #p  
       from #t   
         
select kid,    
       card 卡号,    
       cdate 刷卡时间,    
       adate 上传时间,    
       zz 症状,    
       devid 设备编号,     
       gunid 枪序列号,  
       ta,  
       toe,   
       tw,   
       -0.000125*POWER(toe2,6)  
       +0.0283429488*POWER(toe2,5)  
       -2.67004808*POWER(toe2,4)  
       +133.762569*POWER(toe2,3)  
       -3758.41829*POWER(toe2,2)  
       +56155.4892*(toe2)  
       -348548.755  
       +toe2 as 计算tw  
         
       from #p  
       order by 计算tw  desc
      
drop table #t,#p  
    
end    
GO
