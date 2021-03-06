USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_update_detail]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:yz   
-- Create date: 2014-10-9  
-- Description:晨检报表数据上传报告明细  
--[mcapp].[dbo].[rep_mc_child_update_detail] 12511,'2014-10-20'  
-- =============================================  
CREATE PROCEDURE [dbo].[rep_mc_child_update_detail]  
  @kid int,  
  @cdate date  
AS  
BEGIN  
 SET NOCOUNT ON;  
   
 create table #result(gunid varchar(20),devid varchar(20),scnt int,cnt int,hcnt int)  
   
   
  --其中  
  insert into #result(gunid,devid, scnt)  
  select d.gunid, d.devid,----今日上传的所有数据  
         COUNT(d.ID)  
    from mcapp..stu_mc_day d  
    where d.kid = @kid  
      and d.adate >= CONVERT(VARCHAR(10),@cdate,120)  
      and d.adate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)  
    group by d.gunid,d.devid  
      
  select d.gunid gunid, d.devid,--今日上传的历史数据  
         COUNT(d.ID) hcnt    
     into #t   
    from mcapp..stu_mc_day d  
    where d.kid = @kid  
     and d.cdate < CONVERT(VARCHAR(10),@cdate,120)  
     and d.adate >= CONVERT(VARCHAR(10),@cdate,120)  
      and d.adate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)  
    group by d.gunid,d.devid  
      
      select d.gunid gunid, d.devid,--今日上传的及时有效数据  
         COUNT(d.ID) cnt    
     into #p  
    from mcapp..stu_mc_day d  
    where d.kid = @kid  
     and d.cdate >= CONVERT(VARCHAR(10),@cdate,120)  
     and d.adate >= CONVERT(VARCHAR(10),@cdate,120)  
      and d.adate < CONVERT(VARCHAR(10),DATEADD(DD,1,@cdate),120)  
    group by d.gunid,d.devid  
      
   update r  
      set r.hcnt = isnull(t.hcnt,0)  
     from #result r  
     left join #t t  
       on r.gunid = t.gunid and r.devid = t.devid  
     
      update r  
      set r.cnt = isnull(p.cnt,0)  
     from #result r  
     left join #p p  
       on r.gunid = p.gunid and r.devid = p.devid  
         
   select (case when gunid not in ('00','')then '晨检枪' +'（'+gunid+'）' 
                when gunid in ('00','') and cast(right(devid,2)as int)between 0 and 10 then '一体机' +'（'+devid+'）' 
                when gunid in ('00','') and cast(right(devid,2)as int)between 11 and 100 then '平板'+'（'+devid+'）'  end) gunid,  
           
          cnt,  
          hcnt  
     into #q
     from #result  
     order by gunid  
     
     select gunid,SUM(cnt)cnt,SUM(hcnt)hcnt  
       from #q
     group by gunid
     
     
   drop table #result,#t,#p,#q
      
    
    
END  
GO
