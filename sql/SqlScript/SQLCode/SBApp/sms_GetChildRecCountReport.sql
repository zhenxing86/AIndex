USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetChildRecCountReport]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：短信接收统计报表
--项目名称：sms
--说明：
--时间：2011-06-24 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[sms_GetChildRecCountReport]
@classid int,
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
insert into #smsmessage_xw select recuserid,count(1) from sms..sms_message_curmonth where cid=@classid and sendtime between @begintime and @endtime  group by recuserid
insert into #smsmessage_xw_temp select recuserid,count(1) from sms..sms_message_temp where cid=@classid and status=0 and sendtime between @begintime and @endtime  group by recuserid
SELECT 
t1.name,(ISNULL(t2.smscount,0)+ISNULL(t3.smscount,0))AS smscount
FROM BasicData.dbo.[user] t1 INNER JOIN BasicData.dbo.user_class t4 on t1.userid=t4.userid
 left join #smsmessage_xw t2 on t1.userid=t2.userid left join #smsmessage_xw_temp t3 on t1.userid=t3.userid
WHERE t4.cid=@classid and t1.deletetag=1 and t1.usertype=0 ORDER BY smscount DESC
drop table #smsmessage_xw
drop table #smsmessage_xw_temp

GO
