USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_readcard_detail]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：办理亲子阅读卡明细
--项目名称：家长增值服务结算报表
--说明：办理亲子阅读卡明细
--时间：2013-3-7 11:50:29
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_class_readcard_detail]
@classid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
begin
	select rp.userid,u.name,COUNT(rp.userid) totalCount,
	SUM(case when period = 0 then 1 else 0 end) * 60 +SUM(case when period = 1 then 1 else 0 end)*100 totalMoney
	from SBApp..readcard_pay rp   --办理亲子阅读卡记录表
	left join BasicData..[user] u on u.userid = rp.userid 
	left join BasicData..user_class uc on uc.userid =u.userid
	left join BasicData..class cls on cls.cid =uc.cid
	where uc.cid = @classid and rp.paydate >= @txttime1 and rp.paydate<= @txttime2
	group by rp.userid,u.name
end

GO
