USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_show_GetListCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：分类取日志总数
--项目名称：zgyeyblog
--说明：
--时间：2009-04-27 22:23:18
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_show_GetListCount]
@categoriestitle nvarchar(30)
 AS 
		DECLARE @TempID int
		DECLARE @categoriesid int
		SELECT @categoriesid=id FROM blog_postsyscategory where title=@categoriestitle
		SELECT @TempID=count(1) FROM blog_postsyscategory_relation t4  INNER JOIN  blog_posts t1 ON t1.postid=t4.postid
--		INNER JOIN blog_user t3 ON t3.userid=t1.userid and t3.activity=1
		WHERE t4.categoryid=@categoriesid and t1.poststatus=1 and t1.deletetag=1 
		RETURN @TempID	





GO
