USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_order_detail]    Script Date: 2014/11/24 23:22:52 ******/
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
CREATE PROCEDURE [dbo].[rep_kin_order_detail]
@kid int
,@txttime1 datetime
,@txttime2 datetime
 AS

if @kid>0
begin
    select o.userid,u.name username,cls.cname,plus_amount,actiondatetime
	from PayApp..order_record o
	left join BasicData..[user] u on o.userid = u.userid 
	left join BasicData..user_class uc on uc.userid =u.userid
	left join BasicData..class cls on cls.cid =uc.cid
	where o.status = 1 and cls.kid = @kid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
end

GO
