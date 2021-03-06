USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_composite_one]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[rep_kin_composite_one]
@txttime1 datetime
,@txttime2 datetime
,@infofrom nvarchar(50)
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

if(@infofrom<>'代理')
begin
insert into #temp(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
select [uid]
,sum(case when [status]='试用期'  then 1 else 0 end)
,sum(case when [status]='欠费'  then 1 else 0 end)
,sum(case when [status]='正常缴费'  then 1 else 0 end)
,sum(case when [status]='已离网'  then 1 else 0 end)
,sum(case when [status]='催费中'  then 1 else 0 end)
,sum(case when [status]='可挖掘潜在客户'  then 1 else 0 end)
,sum(case when kid=0  then 1 else 0 end)
,sum(case when rid is null  then 1 else 0 end)
,sum(case when rid>0  then 1 else 0 end)
 from dbo.rep_kin_composite
where regdatetime between @txttime1 and @txttime2 and infofrom=@infofrom
group by [uid]


select u.name,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9),u.ID from ossapp..users u
inner join ossapp..[role] r on r.ID =u.roleid
left join #temp t on t.a0=u.ID
where @infofrom=CONVERT(nvarchar(2),r.name) and u.deletetag=1 and r.deletetag=1
group by u.name,u.ID
union all
select '其他' name,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9),0 from #temp
where a0 is null
union all
select '合计' name,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9),0 from #temp

end
else 
begin

insert into #temp(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9)
select abid
,sum(case when [status]='试用期'  then 1 else 0 end)
,sum(case when [status]='欠费'  then 1 else 0 end)
,sum(case when [status]='正常缴费'  then 1 else 0 end)
,sum(case when [status]='已离网'  then 1 else 0 end)
,sum(case when [status]='催费中'  then 1 else 0 end)
,sum(case when [status]='可挖掘潜在客户'  then 1 else 0 end)
,sum(case when kid=0  then 1 else 0 end)
,sum(case when rid is null  then 1 else 0 end)
,sum(case when rid>0  then 1 else 0 end)
 from dbo.rep_kin_composite
where regdatetime between @txttime1 and @txttime2
group by abid


select a.name,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9),a.ID from ossapp..agentbase a
left join #temp t on t.a0=a.ID
where  a.deletetag=1
group by a.name,a.ID
union all
select '其他' name,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9),0 from #temp
where a0 is null
union all
select '合计' name,SUM(a1),SUM(a2),SUM(a3),SUM(a4),SUM(a5),SUM(a6),SUM(a7),SUM(a8),SUM(a9),0 from #temp


end







drop table #temp



GO
