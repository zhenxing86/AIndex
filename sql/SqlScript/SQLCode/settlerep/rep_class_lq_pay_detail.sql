USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_lq_pay_detail]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：乐奇思维训练课程购买明细
--项目名称：家长增值服务结算报表
--说明：乐奇思维训练课程购买明细
--时间：2013-3-7 11:50:29
------------------------------------ 
ALTER PROCEDURE [dbo].[rep_class_lq_pay_detail]
@classid int
,@txttime1 datetime
,@txttime2 datetime
 AS

if @classid>0 
begin
	select lq.userid,u.name username,COUNT(lq.userid) totalCount ,COUNT(lq.userid)*10 totalmoney
	from gameapp..lq_paydetail lq
	left join BasicData..[user] u on lq.userid = u.userid 
	left join BasicData..user_class uc on uc.userid =u.userid
	left join BasicData..class cls on cls.cid =uc.cid
	where uc.cid = @classid and paydate >= @txttime1 and paydate<= @txttime2
	group by lq.userid,u.name
end
GO
