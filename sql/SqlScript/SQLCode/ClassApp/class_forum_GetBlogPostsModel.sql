USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetBlogPostsModel]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到博客日志的详细信息 
--项目名称：CodematicDemo
--说明：
--时间：2009-4-20 9:52:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_GetBlogPostsModel]
@postid int
 AS 

	SELECT 
	t1.postid AS classforumid,t1.title,t1.content AS contents,t4.userid,t1.author,t5.kid,0,t1.postdatetime AS createdatetime,0 AS istop,0 AS parentid,0 as commentcount,
	t1.userid AS bloguserid,0
	 FROM BlogApp.dbo.blog_posts t1
--			INNER JOIN 	BlogApp.dbo.blog_posts_class t3
--			ON t1.postid=t3.postid
			INNER JOIN Basicdata.dbo.user_bloguser t4 on t1.userid=t4.bloguserid
			inner join Basicdata.dbo.[user] t5 on t4.userid=t5.userid
	 WHERE t1.postid=@postid

GO
