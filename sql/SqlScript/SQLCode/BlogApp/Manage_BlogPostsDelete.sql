USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogPostsDelete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除日记文章
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 06:55:19
--作者：along
------------------------------------
create PROCEDURE [dbo].[Manage_BlogPostsDelete]
@postid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	

	DECLARE @categoriesid int
	DECLARE @userid int
	SELECT @categoriesid=categoriesid,@userid=userid FROM blog_posts WHERE postid=@postid

	--更新日志分类表日志数量	
	UPDATE blog_postscategories SET postcount=postcount-1 
	WHERE categoresid=@categoriesid

	--更新博客配置表日志总数量
	UPDATE blog_baseconfig SET postscount=postscount-1
	WHERE userid=@userid
	
	--DELETE blog_posts_class WHERE postid=@postid

	--删除日记文章
	--DELETE blog_posts WHERE postid=@postid 
	UPDATE blog_posts set deletetag=0 where postid=@postid

	--删除收藏夹日记文章
	DELETE blog_collection
	WHERE postid=@postid

	INSERT INTO blog_messagebox(
	[touserid],[fromuserid],[msgtitle],[msgcontent],[sendtime],[viewstatus]
	)VALUES(
	@userid,-1,'幼儿园门户提醒您','您好，由于接到上级部门通知，我们不得不删除您发表的涉及敏感话题内容，非常抱歉！',getdate(),0
	)

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END






GO
