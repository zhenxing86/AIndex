USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_ClassScheduleGetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取教学安排列表
--项目名称：manage
--说明：
--时间：2009-6-12 17:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_ClassScheduleGetList]
@count nvarchar(10),
@strwhere nvarchar(300)
AS

SET @count = CommonFun.dbo.FilterSQLInjection(@count)
SET @strwhere = CommonFun.dbo.FilterSQLInjection(@strwhere)

	DECLARE @strSQL NVARCHAR(1000)
	SET @strSQL='select TOP('+@count+') t1.scheduleid as docid,t3.kname,t2.cname as classname,t1.title,t1.author,t4.account as loginname,t1.createdatetime,t1.classid
	 from classapp.dbo.class_schedule t1 inner join basicdata.dbo.class t2 on t1.classid=t2.cid
 inner join basicdata.dbo.kindergarten t3 on t2.kid=t3.kid 
inner join basicdata.dbo.[user] t4 on t1.userid =t4.userid and t4.deletetag=1 '+@strwhere +' order by t1.createdatetime desc'
	exec (@strSQL)

GO
