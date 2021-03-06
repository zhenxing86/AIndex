USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetChildRecCountReport]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：短信接收统计报表
--项目名称：classhomepage
--说明：
--时间：2009-12-23 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_sms_GetChildRecCountReport]
@classid int,
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
insert into #smsmessage_xw select recuserid,count(1) from kmp..t_smsmessage_xw where cid=@classid and sendtime between @begintime and @endtime  group by recuserid
insert into #smsmessage_xw_temp select recuserid,count(1) from kmp..t_smsmessage_xw_temp where cid=@classid and status=0 and sendtime between @begintime and @endtime  group by recuserid

SELECT 
t1.name,ISNULL((select smscount from #smsmessage_xw where userid=t1.userid),0)+ISNULL((select smscount from #smsmessage_xw_temp where userid=t1.userid),0)AS smscount
FROM kmp..t_child t1 
WHERE t1.classid=@classid and t1.status=1 ORDER BY smscount DESC

drop table #smsmessage_xw
drop table #smsmessage_xw_temp

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'class_sms_GetChildRecCountReport', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
