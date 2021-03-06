USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_readcard_GetList]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计班级办理亲子阅读卡数量
--项目名称：家长增值服务结算报表
--说明：班级办理亲子阅读卡数量统计
--时间：2013-3-7 11:50:29
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_class_readcard_GetList]
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
	select cid,cname,SUM(totalMoney) totalMoney,COUNT(userid) totalCount
	from(
		select uc.cid,c.cname,rp.userid,
		SUM(case when period = 0 then 1 else 0 end) * 60 +SUM(case when period = 1 then 1 else 0 end)*100 totalMoney
		from SBApp..readcard_pay rp 
		left join BasicData..[user] u on u.userid = rp.userid
		left join BasicData..user_class uc on uc.userid = rp.userid
		left join BasicData..class c on c.cid = uc.cid
		where  u.kid = @kid and rp.paydate >= @txttime1 and rp.paydate<= @txttime2
		group by uc.cid,c.cname,rp.userid
	)t
	group by cid,cname
	
	insert into #temp(cid,cname,totalMoney,totalCount)
	select 0,'合计',isnull(SUM(totalMoney),0) totalMoney,isnull(SUM(totalCount),0) totalCount
	from #temp

	select cid,(case when cid is null then '其他(注：小朋友已离园)' else cname end) cname,totalMoney,totalCount from #temp 
	order by (case when cid>0 then -1 when cid is null then 0 else 1 end) asc,totalCount

	drop table #temp
end

GO
