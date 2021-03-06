USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetClassCountByKindergarten]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取幼儿园班级主页各栏目统计数
--项目名称：manage
--说明：
--时间：2009-6-10 11:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetClassCountByKindergarten]
@where nvarchar(100),
@photowhere nvarchar(100),
@videowhere nvarchar(100),
@accesswhere nvarchar(100),
@kinwhere nvarchar(200)
AS

SET @where = CommonFun.dbo.FilterSQLInjection(@where)
SET @photowhere = CommonFun.dbo.FilterSQLInjection(@photowhere)
SET @videowhere = CommonFun.dbo.FilterSQLInjection(@videowhere)
SET @accesswhere = CommonFun.dbo.FilterSQLInjection(@accesswhere)
SET @kinwhere = CommonFun.dbo.FilterSQLInjection(@kinwhere)

	DECLARE @strSQL  nvarchar(4000)
	SET @strSQL='SELECT top(100) t1.kid as ID,t1.kname as Name,
	(select count(1) from class_notice t2 where t2.kid=t1.kid '+@where+') as noticecount,
	(select count(1) from class_album t2 where t2.kid=t1.kid '+@where+') as albumcount,
	(select count(1) from class_photos t2 inner join class_album t3 on t2.albumid=t3.albumid where t3.kid=t1.kid '+@photowhere+') as photocount,
	(select count(1) from classapp.dbo.class_schedule t2 where t2.kid=t1.kid '+@where+') as schedulecount,
	(select count(1) from class_forum t2 where t2.parentid=0 and t2.kid=t1.kid '+@where+') as forumcount,
	(select count(1) from class_video where kid=t1.kid '+@videowhere+') as videocount,
	(select sum(accessnum) from classapp.dbo.class_config t2 inner join basicdata.dbo.class t3 on t2.cid=t3.cid where t3.kid=t1.kid) as accesscount
	 FROM basicdata.dbo.kindergarten t1  WHERE t1.deletetag=1 '+@kinwhere
	EXEC (@strSQL)

GO
