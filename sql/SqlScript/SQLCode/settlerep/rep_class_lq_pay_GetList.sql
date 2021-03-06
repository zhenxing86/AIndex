USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_lq_pay_GetList]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计班级乐奇思维训练课程购买
--项目名称：家长增值服务结算报表
--说明：班级乐奇思维训练课程购买统计
--时间：2013-3-7 11:50:29

------------------------------------ 
alter PROCEDURE [dbo].[rep_class_lq_pay_GetList]
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
		,totalMoney int
		,totalCount int
	)
    insert into #temp(cid,cname,totalMoney,totalCount)
    select cid,cname,sum(personCount)*10 totalMoney,COUNT(userid) totalCount
    from(
        select uc.cid,c.cname,lq.userid,COUNT(lq.userid) personCount
		from gameapp..lq_paydetail lq
		left join BasicData..[user] u on u.userid = lq.userid
		left join BasicData..user_class uc on uc.userid = lq.userid
		left join BasicData..class c on c.cid = uc.cid
		where u.kid = @kid and paydate >= @txttime1 and paydate<= @txttime2
		group by uc.cid,c.cname,lq.userid
		)t
	group by cid,cname
	order by cname
	
	insert into #temp(cid,cname,totalMoney,totalCount)
	select 0,'合计',isnull(SUM(totalMoney),0) totalMoney,isnull(SUM(totalCount),0) totalCount
	from #temp

	select cid,(case when cid is null then '其他(注：小朋友已离园)' else cname end) cname,totalMoney,totalCount from #temp 
	order by (case when cid>0 then -1 when cid is null then 0 else 1 end) asc,totalCount
	drop table #temp
end
GO
