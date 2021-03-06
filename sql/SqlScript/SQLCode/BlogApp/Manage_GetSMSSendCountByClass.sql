USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetSMSSendCountByClass]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取班级短信发送统计数
--项目名称：manage
--说明：
--时间：2009-6-17 11:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetSMSSendCountByClass]
@sendtime nvarchar(100),
@kinwhere nvarchar(300)
AS

SET @sendtime = CommonFun.dbo.FilterSQLInjection(@sendtime)
SET @kinwhere = CommonFun.dbo.FilterSQLInjection(@kinwhere)

	DECLARE @strSQL  nvarchar(4000)
	SET @strSQL='select t1.cid as id,t1.cname as name,
(select count(1) from sms.dbo.sms_message where status=1 and cid=t1.cid '+@sendtime+') as successcount,
(select count(1) from sms.dbo.sms_message where cid=t1.cid and (status=0 or status=2) '+@sendtime+') as failcount
from basicdata.dbo.class t1 where t1.status=1' +@kinwhere
	EXEC (@strSQL)

GO
