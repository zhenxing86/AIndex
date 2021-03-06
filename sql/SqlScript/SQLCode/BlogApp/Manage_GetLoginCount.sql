USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetLoginCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取登录数列表
--项目名称：manage
--说明：
--时间：2009-6-16 11:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetLoginCount]
@strwhere nvarchar(300)
AS

SET @strwhere = CommonFun.dbo.FilterSQLInjection(@strwhere)

	DECLARE @strSQL NVARCHAR(2000)
	SET @strSQL='select t5.kid as id,t5.kname as name,
(select count(1) 
   from applogs.dbo.log_login t1
     inner join basicdata.dbo.[user] t2 
       on t1.userid=t2.userid
   where t2.kid=t5.kid
     and t2.usertype>0) as stafferlogincount,
(select count(1)
   from applogs.dbo.log_login t1
     inner join basicdata.dbo.[user] t2
       on t1.userid=t2.userid
   where t2.kid=t5.kid
     and t2.usertype=0) as childlogincount
from basicdata.dbo.kindergarten t5 '+@strwhere 
	exec (@strSQL)

GO
