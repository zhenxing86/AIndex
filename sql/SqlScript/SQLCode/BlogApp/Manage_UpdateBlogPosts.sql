USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_UpdateBlogPosts]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改日记文章 
--项目名称：zgyeyblog
--说明：
--时间：2008-12-16 13:55:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_UpdateBlogPosts]
@postid int,
@content ntext
 AS 
	UPDATE blog_posts SET 
	[content] = @content
	WHERE postid=@postid 

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END





GO
