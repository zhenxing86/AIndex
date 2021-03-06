USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetChildHistoryRecCountReport]    Script Date: 2014/11/24 23:27:51 ******/
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
CREATE PROCEDURE [dbo].[sms_GetChildHistoryRecCountReport]
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
insert into #smsmessage_xw select recuserid,count(1) from SMS_2013..sms_message_03 where cid=@classid and sendtime between @begintime and @endtime  group by recuserid

SELECT 
t1.name,ISNULL(t2.smscount,0)AS smscount
FROM BasicData.dbo.[user] t1 inner join BasicData.dbo.user_class t3 on t1.userid=t3.userid
 left join #smsmessage_xw t2 on t1.userid=t2.userid 
WHERE t3.cid=@classid and t1.deletetag=1 and t1.usertype=0 ORDER BY smscount DESC
drop table #smsmessage_xw
drop table #smsmessage_xw_temp

GO
