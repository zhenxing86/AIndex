USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetNewList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：最新日记文章列表
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetNewList]
@userid int,
@isself int
 AS 
	IF(@isself=0)
	BEGIN
		SELECT top 5
		postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,
		IsTop,IsSoul,postupdatetime,commentcount,viewcounts,smile,
		--dbo.PostCategoryTitle(categoriesid) as CategoryTitle,
		'' as CategoryTitle,
		viewpermission
		 FROM blog_posts
		WHERE userid=@userid AND poststatus=1 and deletetag=1
		order by postid desc
	END
	ELSE
	BEGIN
		SELECT top 5
		postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,
		IsTop,IsSoul,postupdatetime,commentcount,viewcounts,smile,
		--dbo.PostCategoryTitle(categoriesid) 
		'' as CategoryTitle,viewpermission
		 FROM blog_posts
		WHERE userid=@userid and deletetag=1 
		order by postid desc
	END
	









GO
