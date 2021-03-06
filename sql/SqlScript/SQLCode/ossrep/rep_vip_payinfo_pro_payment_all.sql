USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_vip_payinfo_pro_payment_all]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_vip_payinfo_pro_payment_all]
@privince int
,@city int
,@area int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
declare @pcount int
 

 create table #temp
 (
 a1 int,
 a2 nvarchar(100),
 a3 varchar(10),
 a4 int,
 a5 int,
 a6 int,
 a7 int,
 a8 int,
 a9 int,
 a0 int,
 a11 int
 )
 

create table #areatemp
(
ID int
,Title nvarchar(100)
,Superior int
,[Level] int
)


insert into #areatemp(ID,Title,Superior,[Level])
select ID,Title,Superior,[Level] from BasicData..Area 
where Superior=0
 
set @pcount=@@ROWCOUNT



insert into #temp(a1,a2,a3,a4,a5,a6,a7,a8,a9,a0,a11)
select @pcount,a.Title ,''
,sum(case when paytype='维护费' and [status]='正常缴费'  and paytime between @txttime1 and @txttime2 then 1 else 0 end)
,sum(case when paytype='VIP费'  and [status]='正常缴费' and paytime between @txttime1 and @txttime2 then 1 else 0 end)
,sum(case when paytype='个性化费用'  and [status]='正常缴费' and paytime between @txttime1 and @txttime2 then 1 else 0 end)
,a.ID
,sum(case when paytype='维护费' and [status]='正常缴费'  and paytime between @txttime1 and @txttime2 then p.paymoney else 0 end)
,sum(case when paytype='VIP费' and [status]='正常缴费'  and paytime between @txttime1 and @txttime2 then p.paymoney else 0 end)
,sum(case when paytype='个性化费用' and [status]='正常缴费' and paytime between @txttime1 and @txttime2 then p.paymoney else 0 end)
,a.[Level]
 from #areatemp a
 left join dbo.rep_vip_payinfo p on a.ID=p.province

group by a.Title,a.[Level],ID order by ID asc

 drop table #areatemp



select a1,a2,a3,a4,a5,a6,a7,a8,a9,a0,a11 from #temp
union all
select '','合计','',sum(a4),sum(a5),sum(a6),sum(a7),sum(a8),sum(a9),sum(a0),0 from #temp

drop table #temp



GO
