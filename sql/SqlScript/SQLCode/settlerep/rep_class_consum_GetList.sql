USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_consum_GetList]    Script Date: 08/10/2013 10:21:39 ******/
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
alter PROCEDURE [dbo].[rep_class_consum_GetList]
@kid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 	
if @kid>0
begin
    create table #temp
	(
		cid int
		,cname nvarchar(100)
		,personCount int
		,moneyCount float
	)
	
	insert into #temp(cid,cname,personCount,moneyCount)
	select cid,cname,COUNT(userid) personCount,SUM(redu_bean)/5.0 beanCount
    from (
		select uc.cid,c.cname,cr.userid,SUM(redu_bean) redu_bean
		from PayApp..consum_record cr 
		left join BasicData..[user] u on u.userid = cr.userid
		left join BasicData..user_class uc on uc.userid = cr.userid
		left join BasicData..class c on c.cid = uc.cid
		where u.kid = @kid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
		group by uc.cid,c.cname,cr.userid
		)t
	group by cid,cname

end


insert into #temp(cid,cname,personCount,moneyCount)
select 0,'合计',isnull(SUM(personCount),0) personCount,isnull(SUM(moneyCount),0) beanCount
from #temp


select cid,(case when cid is null then '其他(注：小朋友已离园)' else cname end) cname,personCount,moneyCount from #temp 
order by (case when cid>0 then -1 when cid is null then 0 else 1 end ) asc ,moneyCount desc

drop table #temp
GO
