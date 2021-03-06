USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_MessageBoxGetList]    Script Date: 06/15/2013 15:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取短消息列表
--项目名称：manage
--说明：
--时间：2009-6-12 16:40:19
------------------------------------ 
alter PROCEDURE [dbo].[Manage_MessageBoxGetList]
@strwhere nvarchar(300),
@count nvarchar(10)
AS

SET @strwhere = CommonFun.dbo.FilterSQLInjection(@strwhere)
SET @count = CommonFun.dbo.FilterSQLInjection(@count)

	DECLARE @strSQL NVARCHAR(1000)
	SET @strSQL='SELECT top('+@count+') t1.touserid,
	(select t3.nickname from basicdata.dbo.user_bloguser t2 inner join basicdata.dbo.user_baseinfo t3 on t2.userid=t3.userid where t2.bloguserid=t1.touserid) as toname,
	t1.fromuserid,(select t3.nickname from basicdata.dbo.user_bloguser t2 inner join basicdata.dbo.user_baseinfo t3 on t2.userid=t3.userid where t2.bloguserid=t1.fromuserid) as fromname,
	t1.msgtitle,t1.msgcontent,t1.sendtime  
	FROM blog_messagebox t1 '+@strwhere +' order by t1.sendtime desc'
	exec (@strSQL)
GO
