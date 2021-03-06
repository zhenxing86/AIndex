USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_total_GetList]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：家长增值服务结算报表
--项目名称：家长增值服务结算报表
--说明：家长增值服务结算报表
--时间：2013-3-7 11:50:29
------------------------------------ 
alter PROCEDURE [dbo].[rep_kin_total_GetList]
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
	s_id int
	,sname nvarchar(100)
	,personCount int
	,moneyCount int
)
	
if len(isnull(@whereSql,''))=0 
begin
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 1,'智慧豆充值',COUNT(userid) personCount,sum(plus_amount) totalMoney
    from (
	select userid,SUM(plus_amount) plus_amount
	from PayApp..order_record o
	where actiondatetime >= @txttime1 and actiondatetime<= @txttime2 and o.[status]=1
	group by userid)t
	
    insert into #temp(s_id,sname,personCount,moneyCount)
    select 2,'数字图书销售',COUNT(userid) personCount,SUM(redu_bean)/5 beanCount
    from (
	select cr.userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	where actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by cr.userid)t
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 3,'亲子阅读卡销售',COUNT(userid) personCount,sum(totalMoney) totalMoney
    from (
	select userid,SUM(case when period = 0 then 1 else 0 end) * 60 +SUM(case when period = 1 then 1 else 0 end)*100 totalMoney
	from SBApp..readcard_pay
	where paydate >= @txttime1 and paydate<= @txttime2
	group by userid)t
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 4,'乐奇思维销售',COUNT(userid) personCount,sum(personCount)*10 totalMoney
    from (
	select userid,COUNT(userid) personCount
	from gameapp..lq_paydetail lq
	where paydate >= @txttime1 and paydate<= @txttime2
	group by userid)t
	
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
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 1,'智慧豆充值',COUNT(userid) personCount,sum(plus_amount) totalMoney
    from (
	select o.userid,SUM(plus_amount) plus_amount
	from PayApp..order_record o
	left join BasicData..[user] u on u.userid = o.userid
	inner join #kintemp k on k.kid =u.kid
	where actiondatetime >= @txttime1 and actiondatetime<= @txttime2 and o.[status]=1
	group by o.userid)t
	
    insert into #temp(s_id,sname,personCount,moneyCount)
    select 2,'数字图书销售',COUNT(userid) personCount,SUM(redu_bean)/5 beanCount
    from (
	select cr.userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	left join BasicData..[user] u on u.userid = cr.userid
	inner join #kintemp k on k.kid =u.kid
	where actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by cr.userid)t
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 3,'亲子阅读卡销售',COUNT(userid) personCount,sum(totalMoney) totalMoney
    from (
	select rp.userid,SUM(case when period = 0 then 1 else 0 end) * 60 +SUM(case when period = 1 then 1 else 0 end)*100 totalMoney
	from SBApp..readcard_pay rp
	left join BasicData..[user] u on u.userid = rp.userid
	inner join #kintemp k on k.kid =u.kid
	where paydate >= @txttime1 and paydate<= @txttime2
	group by rp.userid)t
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 4,'乐奇思维销售',COUNT(userid) personCount,sum(personCount)*10 totalMoney
    from (
	select lq.userid,COUNT(lq.userid) personCount
	from gameapp..lq_paydetail lq
	left join BasicData..[user] u on u.userid = lq.userid
	inner join #kintemp k on k.kid =u.kid
	where paydate >= @txttime1 and paydate<= @txttime2
	group by lq.userid)t
	
	drop table #kintemp
end


insert into #temp(s_id,sname,personCount,moneyCount)
select 0,'合计','' personCount,isnull(SUM(moneyCount),0) beanCount
from #temp
where s_id >1

select s_id,sname,personCount,moneyCount from #temp 

drop table #temp


--exec rep_kin_consum_GetList 0,0,0,16,'',0,0,0,'2012-03-18','2013-03-18'
--userid 81	account 13811111111 kid 16
GO
