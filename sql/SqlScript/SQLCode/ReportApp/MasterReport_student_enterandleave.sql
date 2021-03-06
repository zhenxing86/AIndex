USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[MasterReport_student_enterandleave]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  yz  
-- Create date: 2014-7-18  
-- Description: 入离园理由  
--[dbo].[MasterReport_student_enterandleave] 12511,'2011-9-1','2014-10-1'  
-- =============================================  
CREATE PROCEDURE [dbo].[MasterReport_student_enterandleave]  
@kid int,    
@time1 datetime,    
@time2 datetime,
@mtype int = 0

    
    
AS  
BEGIN  
  
 SET NOCOUNT ON;  
 
 select '掌握幼儿非正常离园（退学）的理由可以了解本园软硬件发方面的劣势<br />从而对症下药进行改进以降低学生的流失率<br /><br />
         掌握幼儿选择本园的理由可以了解本园吸引生源的优势所在<br />从而进一步调整招生策略突显本园的优势和特色'string
 

    
-------------------------------------------------------------------------------  

if @kid = 12511

set @time1 = '2011-9-1'
set @time2 ='2014-10-30'  

if @mtype <> 2
begin
  
select Caption reason,COUNT(l.userid) cnt -------- 获取入园理由分布  
  into #temp1  
  from BasicData..[user] l  
   inner join BasicData..dict_xml  d  
      on l.enrollmentreason = d.Code  
   where d.Catalog = '入园原因'  
     and l.enrollmentreason is not null  
     and l.enrollmentdate between @time1 and @time2  
     and l.kid = @kid  
     and l.deletetag=1  
   group by Caption  
     
union all  
  
select '未填写'reason,COUNT(1) cnt  
  from BasicData..[user] l  
 where l.enrollmentdate between @time1 and @time2  
     and l.kid = @kid  
     and l.deletetag=1  
     and (enrollmentreason is null or enrollmentreason ='')    
     
 declare @sum1 int
 set @sum1 = (select SUM(cnt)from #temp1)
       
 select reason,
        cnt,
        @sum1 scnt
 from #temp1  
 order by (case when reason = '未填写' then 6 end),reason  
 drop table  #temp1
 end
   
-------------------------------------------------------------------------------  
  
if @mtype <> 1
BEGIN
select Caption reason,COUNT(l.userid) cnt -------- 获取离园理由分布  
  into #temp2  
  from BasicData..leave_kindergarten l  
   inner join BasicData..dict_xml  d  
      on l.leavereason = d.Code  
   where d.Catalog = '离园原因'  
     and l.leavereason is not null  
     and l.outtime between @time1 and @time2  
     and l.kid = @kid  
   group by Caption  
     
union all  
  
select '未填写'reason,COUNT(1) cnt  
  from BasicData..leave_kindergarten l  
  inner join  BasicData..[user] u  
       on l.userid = u.userid  
 where l.outtime between @time1 and @time2  
     
     and l.kid = @kid  
     and (l.leavereason is null or l.leavereason ='')   
     
declare @sum2 int
set @sum2 = (select SUM(cnt)from #temp2) 
        
 select reason,
        cnt,
        @sum2 scnt
    from #temp2  
  group by reason,cnt
 order by (case when reason = '原因不详' then 5   
                when reason = '其它' then 6   
                when reason = '未填写' then 7 end),reason  
   
 drop table #temp2
 END  

   
 END  
GO
