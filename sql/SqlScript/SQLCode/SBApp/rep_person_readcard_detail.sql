USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_person_readcard_detail]    Script Date: 2014/11/24 23:27:20 ******/
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
CREATE PROCEDURE [dbo].[rep_person_readcard_detail]
@userid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
if @userid>0
begin
	select rp.userid,(case when rp.period=0 then '一学期' when rp.period =1 then '一年' end) period,rp.paydate 
	from SBApp..readcard_pay rp   --办理亲子阅读卡记录表
	where rp.userid = @userid and rp.paydate >= @txttime1 and rp.paydate<= @txttime2
	
end







GO
