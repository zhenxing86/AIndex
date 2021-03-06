USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：日记文章列表
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetList]
 AS 
	SELECT top 100
	t1.postid,t1.author,t1.userid,t1.postdatetime,t1.title,t1.content,t1.poststatus,t1.categoriesid,t1.commentstatus,t1.IsTop,
	t1.IsSoul,t1.postupdatetime,t1.commentcount,t1.viewcounts,t1.smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle
	 FROM blog_posts t1 inner join BasicData.dbo.user_bloguser t2 on t1.userid=t2.bloguserid inner join BasicData.dbo.[user] t3 on t2.userid=t3.userid 
	WHERE t1.title <>'我的博客开通啦' and t1.poststatus=1 and t1.deletetag=1 and datediff(day,t3.regdatetime,getdate())>3 and t3.deletetag=1 
	order by t1.istop desc, t1.postupdatetime desc



GO
