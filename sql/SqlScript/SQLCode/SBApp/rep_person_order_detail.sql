USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_person_order_detail]    Script Date: 2014/11/24 23:27:20 ******/
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
CREATE PROCEDURE [dbo].[rep_person_order_detail]
@userid int
,@txttime1 datetime
,@txttime2 datetime
 AS

if @userid>0
begin
    select o.userid,plus_amount,actiondatetime
	from PayApp..order_record o
	where o.status = 1 and o.userid = @userid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
end








GO
