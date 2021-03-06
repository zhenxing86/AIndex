USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetStafferSendCountReport]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：短信发送统计报表
--项目名称：sms
--说明：
--时间：2011-06-24 14:54:31
------------------------------------
alter PROCEDURE [dbo].[sms_GetStafferSendCountReport]
@kid int,
@begintime nvarchar(30),
@endtime nvarchar(30)
AS
CREATE TABLE #smsmessage_xw
(
	userid int,
	smscount int
)
CREATE TABLE #smsmessage_xw_temp
(
	userid int,
	smscount int
)

insert into #smsmessage_xw select sender,count(1) from sms..sms_message_curmonth where kid=@kid and sendtime between @begintime and @endtime  group by sender
insert into #smsmessage_xw_temp select sender,count(1) from sms..sms_message_temp where kid=@kid and status=0 and sendtime between @begintime and @endtime  group by sender

SELECT 
t1.name,(ISNULL(t2.smscount,0)+ISNULL(t5.smscount,0))AS smscount
FROM BasicData.dbo.[user] t1
 left join #smsmessage_xw t2 on t1.userid=t2.userid left join #smsmessage_xw_temp t5 on t1.userid=t5.userid
WHERE t1.kid=@kid and t1.deletetag=1 and t1.usertype in (1,97,98) ORDER BY smscount DESC

drop table #smsmessage_xw
drop table #smsmessage_xw_temp
GO
