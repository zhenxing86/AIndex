USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_consum_detail]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：数字图书购买明细
--项目名称：家长增值服务结算报表
--说明：数字图书购买明细
--时间：2013-3-7 11:50:29
------------------------------------ 
CREATE PROCEDURE [dbo].[rep_kin_consum_detail]
@kid int
,@txttime1 datetime
,@txttime2 datetime
 AS
 
declare @pcount int
,@excuteSql nvarchar(2000),@whereSql nvarchar(2000)

set @whereSql=''
if @kid>0
begin
	select cr.userid,u.name username,cls.cname,sb.book_title,actiondatetime
	from PayApp..consum_record cr
	left join SBApp..sb_book sb on sb.sbid = cr.sbid
	left join BasicData..[user] u on cr.userid = u.userid 
	left join BasicData..user_class uc on uc.userid =u.userid
	left join BasicData..class cls on cls.cid =uc.cid
	where cls.kid = @kid and actiondatetime >= @txttime1 and actiondatetime<= @txttime2
end

GO
