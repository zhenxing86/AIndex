USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_person_lq_pay_detail]    Script Date: 08/10/2013 10:21:40 ******/
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
alter PROCEDURE [dbo].[rep_person_lq_pay_detail]
@userid int
,@txttime1 datetime
,@txttime2 datetime
 AS

if @userid>0
begin
	select lq.userid,
	(case when lq.lq_gradeid=1 then '阶梯1' when lq.lq_gradeid=2 then '阶梯2' when lq.lq_gradeid=3 then '阶梯3' end )grade ,paydate
	from gameapp..lq_paydetail lq
	where lq.userid = @userid and paydate >= @txttime1 and paydate<= @txttime2
	
end

GO
