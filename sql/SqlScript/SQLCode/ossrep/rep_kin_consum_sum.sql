USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_consum_sum]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计数字图书购买
--项目名称：家长增值服务结算报表
--说明：数字图书购买统计
--时间：2013-3-7 11:50:29

------------------------------------ 
CREATE PROCEDURE [dbo].[rep_kin_consum_sum]
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
if @city >0  --省、市
begin
	set @whereSql =@whereSql+' and city ='+Str(@city) 
end
if @area>0  --省、市、县
begin
	set @whereSql =@whereSql+' and area ='+Str(@area) 
end

if @sourceType=1 --市场
begin
	set @whereSql =@whereSql+' and infofrom =''市场人员''' 
	if @developer>0
	begin
		set @whereSql =@whereSql+' and uid ='+Str(@developer)
	end 
end
else if @sourceType=2 --网络
begin
	set @whereSql =@whereSql+' and infofrom =''客服人员'''
	if @developer>0
	begin
		set @whereSql =@whereSql+' and uid ='+Str(@developer)
	end 
end
else if @sourceType=3 --代理
begin
	set @whereSql =@whereSql+' and abid <>0'
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
	,moneyCount int
)
	
if len(isnull(@whereSql,''))=0 
begin
    insert into #temp(kid,kname,personCount,moneyCount)
	select kid,kname,COUNT(userid) personCount,SUM(redu_bean)/30 beanCount
	from 
	(select u.kid,kg.kname,COUNT(cr.userid) userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	left join BasicData..[user] u on u.userid = cr.userid
	left join BasicData..kindergarten kg on kg.kid =u.kid
	where actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by u.kid,kg.kname,cr.userid
	)t
	group by kid,kname
	order by personCount desc
	
	
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
	insert into #temp(kid,kname,personCount,moneyCount)
	select kid,kname,COUNT(userid) personCount,SUM(redu_bean)/30 beanCount
	from 
	(select u.kid,kg.kname,COUNT(cr.userid) userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	left join BasicData..[user] u on u.userid = cr.userid
	left join BasicData..kindergarten kg on kg.kid =u.kid
	inner join #kintemp k on k.kid =u.kid
	where actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by u.kid,kg.kname,cr.userid
	)t
	group by kid,kname
	order by personCount desc
	
	select 1,* from #temp
	
	drop table #kintemp
end

select kid,kname,personCount,moneyCount from #temp 
union all
select 0,'合计',isnull(SUM(personCount),0) personCount,isnull(SUM(moneyCount),0) beanCount
from #temp

drop table #temp

GO
