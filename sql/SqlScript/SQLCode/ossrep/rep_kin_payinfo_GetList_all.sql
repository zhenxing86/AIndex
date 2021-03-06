USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_payinfo_GetList_all]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[rep_kin_payinfo_GetList_all]
@privince int
,@city int
,@area int
as 


declare @pcount int

 create table #temp
 (
 a1 int,
 a2 nvarchar(100),
 a3 int,
 a4 int,
 a5 int,
 a6 int,
 a11 int
 )


declare @txttime1 datetime,@txttime2 datetime,@txttime3 datetime,@txtnow datetime

set @txtnow=GETDATE()

set @txttime1=DATEADD(MM,-1,@txtnow)

set @txttime2=DATEADD(MM,-2,@txtnow)

set @txttime3=DATEADD(MM,-3,@txtnow)




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

insert into #temp(a1,a2,a3,a4,a5,a6,a11)
select @pcount
,a.Title
,sum(case when lasttime between @txttime1 and @txtnow  then 1 else 0 end)
,sum(case when lasttime between @txttime2 and @txttime1  then 1 else 0 end)
,sum(case when lasttime <= @txttime3  then 1 else 0 end)
,a.ID,a.[Level]
 from BasicData..#areatemp a
 left join dbo.rep_kin_payinfo p on a.ID=p.province
 where  [status]='欠费'
group by a.Title,a.[Level],ID order by ID asc


drop table #areatemp


select (a1+1),a2,a3,a4,a5,a6,a11 from #temp
union all
select '','合计',sum(a3),sum(a4),sum(a5),sum(a6),0 from #temp




drop table #temp


GO
