USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[rep_person_consum_detail]    Script Date: 2014/11/24 23:27:20 ******/
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
CREATE PROCEDURE [dbo].[rep_person_consum_detail]
@userid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
if @userid>0
begin
	select cr.userid,sb.book_title,cr.redu_bean/5.0 bymoney,actiondatetime
	from PayApp..consum_record cr
	left join SBApp..sb_book sb on sb.sbid = cr.sbid
	where cr.userid = @userid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
end




GO
