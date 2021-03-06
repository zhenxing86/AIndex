USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_total_GetList]    Script Date: 2014/11/24 23:27:20 ******/
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
CREATE PROCEDURE [dbo].[rep_class_total_GetList]
@kid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 	
if @kid>0
begin
    create table #temp
	(
		s_id int
		,sname nvarchar(100)
		,personCount int
		,moneyCount int
	)
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 1,'智慧豆充值',COUNT(userid) personCount,sum(plus_amount) totalMoney
    from (
	select o.userid,SUM(plus_amount) plus_amount
	from PayApp..order_record o
	left join BasicData..[user] u on u.userid = o.userid
	where u.kid = @kid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2 and o.[status]=1
	group by o.userid)t
	
    insert into #temp(s_id,sname,personCount,moneyCount)
    select 2,'数字图书销售',COUNT(userid) personCount,SUM(redu_bean)/5 beanCount
    from (
	select cr.userid,SUM(redu_bean) redu_bean
	from PayApp..consum_record cr 
	left join BasicData..[user] u on u.userid = cr.userid
	where u.kid = @kid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by cr.userid)t
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 3,'亲子阅读卡销售',COUNT(userid) personCount,sum(totalMoney) totalMoney
    from (
	select rp.userid,SUM(case when period = 0 then 1 else 0 end) * 60 +SUM(case when period = 1 then 1 else 0 end)*100 totalMoney
	from SBApp..readcard_pay rp
	left join BasicData..[user] u on u.userid = rp.userid
	where u.kid = @kid and paydate >= @txttime1 and paydate<= @txttime2
	group by rp.userid)t
	
	insert into #temp(s_id,sname,personCount,moneyCount)
    select 4,'乐奇思维销售',COUNT(userid) personCount,sum(personCount)*10 totalMoney
    from (
	select lq.userid,COUNT(lq.userid) personCount
	from gameapp..lq_paydetail lq
	left join BasicData..[user] u on u.userid = lq.userid
	where u.kid = @kid and paydate >= @txttime1 and paydate<= @txttime2
	group by lq.userid)t
	
end
	
insert into #temp(s_id,sname,personCount,moneyCount)
select 0,'合计','' personCount,isnull(SUM(moneyCount),0) beanCount
from #temp

select s_id,sname,personCount,moneyCount from #temp 

drop table #temp

GO
