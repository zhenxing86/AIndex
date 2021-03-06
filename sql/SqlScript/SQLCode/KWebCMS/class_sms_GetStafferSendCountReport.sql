USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetStafferSendCountReport]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：短信发送统计报表
--项目名称：classhomepage
--说明：
--时间：2009-12-23 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_sms_GetStafferSendCountReport]
@kid int,
@begintime nvarchar(30),
@endtime nvarchar(30)
AS
create table #smsmessage_xw
(
	userid int,
	smscount int
)
create table #smsmessage_xw_temp
(
	userid int,
	smscount int
)
insert into #smsmessage_xw select sender,count(1) from kmp..t_smsmessage_xw where kid=@kid and sendtime between @begintime and @endtime  group by sender
insert into #smsmessage_xw_temp select sender,count(1) from kmp..t_smsmessage_xw_temp where kid=@kid and status=0 and sendtime between @begintime and @endtime  group by sender

SELECT 
t1.name,ISNULL((select smscount from #smsmessage_xw where userid=t1.userid),0)+ISNULL((select smscount from #smsmessage_xw_temp where userid=t1.userid),0)AS smscount
FROM kmp..t_staffer t1 
WHERE t1.kindergartenid=@kid and t1.status=1 ORDER BY smscount DESC

drop table #smsmessage_xw
drop table #smsmessage_xw_temp


GO
