USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_vip_detail_index_new]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_vip_detail_index_new]
@area int
,@city int
,@paytype nvarchar(20)
,@txttime1 datetime
,@txttime2 datetime
 AS
 
 create table #temp(
 p int,
 kid int,
 kname nvarchar(100),
 paytime datetime,
 paymoney int,
 name nvarchar(100),
 [status] nvarchar(10)
 )
 
 
 if(exists(select 1 from BasicData..Area where ID=@area and [level]=0) and @city=0)
  begin
   insert into #temp(p,kid,kname,paytime,paymoney,name,[status])
  select 1,kid,kname,paytime,paymoney,a.name,[status] from rep_vip_new r
  left join ossapp..agentbase a on a.ID=abid 
  where paytype=@paytype and province=@area and paytime between @txttime1 and @txttime2 
  order by paytime desc
  end
   else if(exists(select 1 from BasicData..Area where ID=@area and [level]=1) and @city<>@area)
  begin
   insert into #temp(p,kid,kname,paytime,paymoney,name,[status])
  select 1,kid,kname,paytime,paymoney,a.name,[status] from rep_vip_new r
  left join ossapp..agentbase a on a.ID=abid 
  where paytype=@paytype and city=@area and paytime between @txttime1 and @txttime2 
  order by abid,kid asc,paytime desc
  end
  else
  begin 
 
  insert into #temp(p,kid,kname,paytime,paymoney,name,[status])
  select 1,kid,kname,paytime,paymoney,a.name,[status] from rep_vip_new r
  left join ossapp..agentbase a on a.ID=abid 
  where paytype=@paytype and areaid=@area and paytime between @txttime1 and @txttime2 
 order by abid,kid asc,paytime desc
 
 end
  
  select p,kid,kname,paytime,paymoney,name,[status] from #temp
  union all
  select 1,0,'合计','',sum(paymoney),'','' from #temp
  
  drop table #temp
  


GO
