USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_readcard_sum]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计办理亲子阅读卡数量
--项目名称：家长增值服务结算报表
--说明：办理亲子阅读卡数量统计
--时间：2013-3-7 11:50:29
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_kin_readcard_sum]
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
	,semiAnnualCount int
	,annualCount int
	,totalMoney int
	,totalCount int
)

--选择列表中的列 'SBApp..readcard_pay.period' 无效，因为该列没有包含在聚合函数或 GROUP BY 子句中。
	
if len(isnull(@whereSql,''))=0 
begin
    insert into #temp(kid,kname,semiAnnualCount,annualCount,totalMoney,totalCount)
	select kid,kname,
	SUM(case when period = 0 then 1 else 0 end)  semiAnnualCount,
	SUM(case when period = 1 then 1 else 0 end) annualCount,
	SUM(case when period = 0 then 1 else 0 end) * 30 +SUM(case when period = 1 then 1 else 0 end)*60 totalMoney,
	COUNT(userid) totalCount
	from 
	(select u.kid,kg.kname,rp.period,COUNT(rp.userid) userid
	from SBApp..readcard_pay rp 
	left join BasicData..[user] u on u.userid = rp.userid
	left join BasicData..kindergarten kg on kg.kid =u.kid
	where  rp.paydate >= @txttime1 and rp.paydate<= @txttime2
	group by u.kid,kg.kname,rp.userid,rp.period
	)t
	group by kid,kname
	order by totalCount desc
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
	insert into #temp(kid,kname,semiAnnualCount,annualCount,totalMoney,totalCount)
	select kid,kname,
	SUM(case when period = 0 then 1 else 0 end)  semiAnnualCount,
	SUM(case when period = 1 then 1 else 0 end) annualCount,
	SUM(case when period = 0 then 1 else 0 end) * 30 +SUM(case when period = 1 then 1 else 0 end)*60 totalMoney,
	COUNT(userid) totalCount
	from 
	(select u.kid,kg.kname,rp.period,COUNT(rp.userid) userid
	from SBApp..readcard_pay rp 
	left join BasicData..[user] u on u.userid = rp.userid
	left join BasicData..kindergarten kg on kg.kid =u.kid
	inner join #kintemp k on k.kid =u.kid
	where  rp.paydate >= @txttime1 and rp.paydate<= @txttime2
	group by u.kid,kg.kname,rp.userid,rp.period
	)t
	group by kid,kname
	order by totalCount desc
	
	drop table #kintemp
end

select kid,kname,semiAnnualCount,annualCount,totalMoney,totalCount from #temp 
union all
select 0,'合计',isnull(SUM(semiAnnualCount),0) semiAnnualCount,isnull(SUM(annualCount),0) annualCount
,isnull(SUM(totalMoney),0) totalMoney,isnull(SUM(totalCount),0) totalCount
from #temp

drop table #temp

GO
