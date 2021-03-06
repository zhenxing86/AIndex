USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetClassCountByClass]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取各班级班级主页各栏目统计数
--项目名称：manage
--说明：
--时间：2009-6-11 11:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_GetClassCountByClass]
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
	SET @strSQL='SELECT  t1.cid as ID,t1.cname as Name,
(select count(1) from classapp.dbo.class_notice t2 where t2.classid=t1.cid '+@where+') as noticecount,
(select count(1) from classapp.dbo.class_album t2 where t2.classid=t1.cid '+@where+') as albumcount,
(select count(1) from classapp.dbo.class_photos t2 inner join classapp.dbo.class_album t3 on t2.albumid=t3.albumid where t3.classid=t1.cid '+@photowhere+') as photocount,
(select count(1) from classapp.dbo.class_schedule t2 where t2.classid=t1.cid '+@where+') as schedulecount,
(select count(1) from classapp.dbo.class_forum t2 where t2.parentid=0 and t2.classid=t1.cid '+@where+') as forumcount,
(select count(1) from classapp.dbo.class_video where classid=t1.cid '+@videowhere+') as videocount,
t3.accessnum  as accesscount  
FROM basicdata.dbo.class t1 inner join classapp.dbo.class_config t3 on t1.cid=t3.cid  WHERE t1.deletetag=1 '+@kinwhere
	EXEC (@strSQL)

GO
