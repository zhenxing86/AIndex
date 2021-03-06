USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_readcard_detail]    Script Date: 2014/11/24 23:22:52 ******/
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
CREATE PROCEDURE [dbo].[rep_kin_readcard_detail]
@paytype nvarchar(50)
,@kid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
if len(isnull(@paytype,''))>0
begin
    if @paytype ='-1'
    begin
		select rp.userid,u.name username,cls.cname,(case when rp.period=0 then '半年' when rp.period =1 then '一年' end) period,rp.paydate 
		from SBApp..readcard_pay rp   --办理亲子阅读卡记录表
		left join BasicData..[user] u on u.userid = rp.userid 
		left join BasicData..user_class uc on uc.userid =u.userid
		left join BasicData..class cls on cls.cid =uc.cid
		where cls.kid = @kid and rp.paydate >= @txttime1 and rp.paydate<= @txttime2
	end
	else
	begin
		select rp.userid,u.name username,cls.cname,(case when rp.period=0 then '半年' when rp.period =1 then '一年' end) period,rp.paydate 
		from SBApp..readcard_pay rp   --办理亲子阅读卡记录表
		left join BasicData..[user] u on u.userid = rp.userid 
		left join BasicData..user_class uc on uc.userid =u.userid
		left join BasicData..class cls on cls.cid =uc.cid
		where rp.period = @paytype and cls.kid = @kid and rp.paydate >= @txttime1 and rp.paydate<= @txttime2
	end
end

GO
