USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_composite_all]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[rep_kin_composite_all]
@txttime1 datetime
,@txttime2 datetime
,@uid int
,@abid int
as 

create table #temp
(
a0 varchar(20)
,a1 int
,a2 int
,a3 int
,a4 int
,a5 int
,a6 int
,a7 int
,a8 int
,a9 int

)

if(@abid>0)
begin

insert into #temp(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
select CONVERT(varchar(7),regdatetime,23)
,sum(case when [status]='试用期'  then 1 else 0 end)
,sum(case when [status]='欠费'  then 1 else 0 end)
,sum(case when [status]='正常缴费'  then 1 else 0 end)
,sum(case when [status]='已离网'  then 1 else 0 end)
,sum(case when [status]='催费中'  then 1 else 0 end)
,sum(case when [status]='可挖掘潜在客户'  then 1 else 0 end)
,sum(case when [status]='营销客户'  then 1 else 0 end)
,sum(case when rid is null  then 1 else 0 end)
,sum(case when rid>0  then 1 else 0 end)
 from dbo.rep_kin_composite
where regdatetime between @txttime1 and @txttime2 and abid=@abid
group by regdatetime

end
else
begin

insert into #temp(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
select CONVERT(varchar(7),regdatetime,23)
,sum(case when [status]='试用期'  then 1 else 0 end)
,sum(case when [status]='欠费'  then 1 else 0 end)
,sum(case when [status]='正常缴费'  then 1 else 0 end)
,sum(case when [status]='已离网'  then 1 else 0 end)
,sum(case when [status]='催费中'  then 1 else 0 end)
,sum(case when [status]='可挖掘潜在客户'  then 1 else 0 end)
,sum(case when [status]='营销客户'  then 1 else 0 end)
,sum(case when rid is null  then 1 else 0 end)
,sum(case when rid>0  then 1 else 0 end)
 from dbo.rep_kin_composite
where regdatetime between @txttime1 and @txttime2 and ([uid]=@uid or @uid=-1)
group by regdatetime

end

declare @a int
set @a=DATEDIFF(MM,@txttime1,@txttime2)
while (@a>=0)
begin
insert into #temp(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
select convert(varchar(7),DATEADD(MM,@a,@txttime1),120),0,0,0,0,0,0,0,0,0
set @a=@a-1
end


select a0,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9) from #temp
group by a0
union all
select '合计',SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9) from #temp
order by a0 asc	

drop table #temp




GO
