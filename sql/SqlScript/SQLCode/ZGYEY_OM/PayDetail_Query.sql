USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[PayDetail_Query]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--[PayDetail_Query] '2011-01-01','2011-12-19',0,10,1
------------------------------------
CREATE PROCEDURE [dbo].[PayDetail_Query]
@time_star datetime,
@time_end datetime,
@status int,--1支付成功,0 待支付状态
@size int,
@page int
 AS 


	BEGIN

		select t4.kname,t2.name,t2.mobile,t2.account,t1.userid,t1.plus_amount,t1.actiondatetime,t1.orderno 
		from payappdemo..order_record t1 
		left join basicdata..[user] t2 on t1.userid=t2.userid
		left join basicdata..kindergarten t4 on t2.kid=t4.kid
		where t1.status=@status and t2.usertype=0 and t1.actiondatetime between @time_star and @time_end
		order by t1.actiondatetime desc
	END

GO
