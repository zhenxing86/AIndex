USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_order_detail]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：智慧豆充值金额明细
--项目名称：家长增值服务结算报表
--说明：智慧豆充值金额明细
--时间：2013-3-7 11:50:29
------------------------------------ 
ALTER PROCEDURE [dbo].[rep_class_order_detail]
@classid int
,@txttime1 datetime
,@txttime2 datetime
 AS

if @classid>0
begin
    select o.userid,u.name username,count(o.userid) totalCount,sum(plus_amount) totalmoney
	from PayApp..order_record o
	left join BasicData..[user] u on o.userid = u.userid 
	left join BasicData..user_class uc on uc.userid =u.userid
	left join BasicData..class cls on cls.cid =uc.cid
	where o.status = 1 and uc.cid = @classid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by o.userid,u.name
end
GO
