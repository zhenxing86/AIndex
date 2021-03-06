USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_bean_sum]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kin_bean_sum]
@privince int
,@city int
,@area int
,@kid int
,@kname varchar(120)
,@sourceType int
,@agent int
,@developer int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
set @kname=CommonFun.dbo.FilterSQLInjection(@kname)

declare @pcount int
,@excuteSql nvarchar(2000),@whereSql nvarchar(2000)

set @whereSql=''
if @privince>0  --省
begin
	set @whereSql =@whereSql+' and privince ='+Str(@privince)
end
else if @city >0  --省、市
begin
	set @whereSql =@whereSql+' and city ='+Str(@city) 
end
else if @area>0  --省、市、县
begin
	set @whereSql =@whereSql+' and area ='+Str(@area) 
end

if @sourceType=1 --市场
begin
	set @whereSql =@whereSql+' and infofrom =''市场''' 
	if @developer>0
	begin
		set @whereSql =@whereSql+' and uid ='+Str(@developer)
	end 
end
else if @sourceType=2 --网络
begin
	set @whereSql =@whereSql+' and infofrom =''网络'''
	if @developer>0
	begin
		set @whereSql =@whereSql+' and uid ='+Str(@developer)
	end 
end
else if @sourceType=3 --代理
begin
	set @whereSql =@whereSql+' and infofrom =''代理'''
	if @agent>0
	begin
		set @whereSql =@whereSql+' and abid ='+Str(@agent)
	end
	if @developer>0
	begin
		set @whereSql =@whereSql+' and developer ='+Str(@developer)
	end
end

if @kid>0
begin
	set @whereSql =@whereSql+' and kid ='+Str(@kid)
end 
if len(isnull(@kname,''))>0
begin
	set @whereSql =@whereSql+' and kname like ''%'+@kname+'%'''
end

create table #temp
(
	kid int
	,kname nvarchar(100)
	,personCount int
	,beanCount int
)
	
if len(isnull(@whereSql,''))=0 
begin
    insert into #temp(kid,kname,personCount,beanCount)
	select kid,kname,COUNT(userid) personCount,SUM(redu_bean) beanCount
	from 
	(select u.kid,kg.kname,COUNT(cr.userid) userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	inner join BasicData..[user] u on u.userid = cr.userid
	inner join BasicData..kindergarten kg on kg.kid =u.kid
	where actiondatetime between @txttime1 and @txttime2
	group by u.kid,kg.kname,cr.userid
	)t
	group by kid,kname
end
else
begin
    
    create table #kintemp
	(
	kid int
	)
	
	
	set @excuteSql='insert into #kintemp(kid) select kid from ossapp..kinbaseinfo where 1=1 '+@whereSql
	exec sp_executesql @excuteSql
	--print @excuteSql
	insert into #temp(kid,kname,personCount,beanCount)
	select kid,kname,COUNT(userid) personCount,SUM(redu_bean) beanCount
	from 
	(select u.kid,kg.kname,COUNT(cr.userid) userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	inner join BasicData..[user] u on u.userid = cr.userid
	inner join BasicData..kindergarten kg on kg.kid =u.kid
	inner join #kintemp k on k.kid =u.kid
	where actiondatetime between @txttime1 and @txttime2
	group by u.kid,kg.kname,cr.userid
	)t
	group by kid,kname
	
	drop table #kintemp
end

select kid,kname,personCount,beanCount from #temp
union all
select 0,'合计',isnull(SUM(personCount),0) personCount,isnull(SUM(beanCount),0) beanCount
from #temp

drop table #temp

GO
