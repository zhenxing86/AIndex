USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_post_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：明星博客首页显示日志列表
--项目名称：zgyeyblog
--说明：
--时间：2009-4-28 16:55:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_startuser_post_GetList]
@usertype int
AS
	IF(@usertype>0)
	BEGIN
		select t1.userid,t4.postid,t4.title from blog_baseconfig t1 inner join blog_startuser t3 on t1.userid=t3.userid
		  inner join blog_posts t4 on t3.postid=t4.postid
		  INNER JOIN BasicData.dbo.user_bloguser t2 ON t1.userid=t2.bloguserid 
		  inner join BasicData.dbo.[user] t5 on t2.userid=t5.userid
		 where t1.isstart=1 and t5.usertype>0 and t5.deletetag=1 order by t4.postupdatetime desc	
	END
	ELSE
	BEGIN
		select t1.userid,t4.postid,t4.title from blog_baseconfig t1 inner join blog_startuser t3 on t1.userid=t3.userid
		  inner join blog_posts t4 on t3.postid=t4.postid
		  INNER JOIN BasicData.dbo.user_bloguser t2 ON t1.userid=t2.bloguserid 
		  inner join BasicData.dbo.[user] t5 on t2.userid=t5.userid
		 where t1.isstart=1 and t5.usertype=@usertype and t5.deletetag=1 order by t4.postupdatetime desc
	END



GO
