USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[initExceptionCount_v2]    Script Date: 05/14/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	初始化异常统计表_演示
-- =============================================
CREATE PROCEDURE [dbo].[initExceptionCount_v2]
@userid int,@bid int
AS
  declare @p int
  
  create table #temp
  (
     uid int,
     tday datetime,
     tresult varchar(100)
  )
  create table #tempuser
  (
    tuid int,
    tsum int,
    tdays datetime
   )
   
   create table #tempcount
   (
     
     tw int,
     lbt int,
     hlfy int,
     ks int,
     fs int,
     hy int,
     szk int,
     fx int,
     pc int,
     jzj int,
     fytx int,
     gohome int
    )
  
  insert into #temp(uid,tday,tresult)
  select userId,checktime,result from HealthApp..CheckRecord where userId = @userid
  select * from #temp
  select * from HealthApp..ExceptionCount where bid = @bid
  set @p=@@ROWCOUNT
  if(@p=0)
   begin
      insert into HealthApp..ExceptionCount (bid,twcount,lbtcount,hlfycount,kscount,fscount,hycount,szkcount
      ,fxcount,pccount,jzjcount,fytxcount,gocount) values (@bid,0,0,0,0,0,0,0,0,0,0,0,0)
   end
  insert into #tempcount (tw,lbt,hlfy,ks,fs,hy,szk,fx,pc,jzj,fytx,gohome) values (null,0,0,0,0,0,0,0,0,0,0,0)
  
  
  ---统计发烧---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%1,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set fs = tsum from #tempuser 
  
  ---统计咳嗽---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%2,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set ks = tsum from #tempuser 
  
  ---喉咙发炎---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%3,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set hlfy = tsum from #tempuser 
  
   ---流鼻涕---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%4,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set lbt = tsum from #tempuser 
  
    ---皮疹---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%5,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set pc = tsum from #tempuser
  
  ---腹泻---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%6,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set fx = tsum from #tempuser
  
   ---红眼病---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%7,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set hy = tsum from #tempuser
  
  ---手足口病---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%8,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set szk = tsum from #tempuser
  
   ---剪指甲---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%9,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set jzj = tsum from #tempuser
  
  ---服药提醒---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%10,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set fytx = tsum from #tempuser
  
  ---家长带回---
  delete #tempuser
  insert into #tempuser(tuid,tsum)
  select uid,sum(case when (tresult like '%11,%') then 1 else 0 end) from #temp
  group by uid
  
  update #tempcount set gohome = tsum from #tempuser
  
  update h set h.bid =@bid,h.fscount =t.fs,h.twcount = t.tw,
  h.lbtcount = t.lbt,h.hlfycount=t.hlfy,h.kscount=t.ks,h.hycount = t.hy,h.szkcount=t.szk,
  h.fxcount = t.fx,h.pccount = t.pc,h.jzjcount = t.jzj,
  h.fytxcount = t.fytx,h.gocount = t.gohome
  from HealthApp..ExceptionCount h,#tempcount t where h.bid = @bid
  
  
  select * from #tempuser
  select * from #tempcount
GO
