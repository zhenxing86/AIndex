USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetSMSSendCountByKindergarten]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取幼儿园短信发送统计数
--项目名称：manage
--说明：
--时间：2009-6-17 11:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetSMSSendCountByKindergarten]
@sendtime nvarchar(100),
@kinwhere nvarchar(300),
@count nvarchar(10)
AS

SET @sendtime = CommonFun.dbo.FilterSQLInjection(@sendtime)
SET @kinwhere = CommonFun.dbo.FilterSQLInjection(@kinwhere)
SET @count = CommonFun.dbo.FilterSQLInjection(@count)

	DECLARE @strSQL  nvarchar(4000)
	SET @strSQL='select '+@count+' t1.kid as id,t1.kname as name,
(select count(1) from sms.dbo.sms_message where status=1 and kid=t1.kid '+@sendtime+') as successcount,
(select count(1) from sms.dbo.sms_message where kid=t1.kid and (status=0 or status=2) '+@sendtime+') as failcount
from basicdata.dbo.kindergarten t1 where (select count(1) from sms.dbo.sms_message where status=1 and kid=t1.kid '+@sendtime+')>0 and t1.status=1' +@kinwhere
	EXEC (@strSQL)

GO
