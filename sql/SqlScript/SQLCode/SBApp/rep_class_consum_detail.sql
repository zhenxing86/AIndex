USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_class_consum_detail]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：班级数字图书购买明细
--项目名称：家长增值服务结算报表
--说明：班级数字图书购买明细
--时间：2013-3-7 11:50:29
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_class_consum_detail]
@classid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
if @classid>0
begin
	select cr.userid,u.name,COUNT(cr.userid) bookCount,SUM(cr.redu_bean)/5.0  moneyCount
	from PayApp..consum_record cr
	left join BasicData..[user] u on cr.userid = u.userid 
	left join BasicData..user_class uc on uc.userid =u.userid
	left join BasicData..class cls on cls.cid =uc.cid
	where uc.cid = @classid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
	group by cr.userid,u.name
end

GO
