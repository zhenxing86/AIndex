USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscategories_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除日志分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-30 22:57:13
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscategories_Delete]
@categoresid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	--删除日志分类
	DELETE blog_postscategories
	 WHERE categoresid=@categoresid 

	--删除日志评论
	--DELETE blog_postscomments 
	-- WHERE postsid in (SELECT postsid FROM blog_posts WHERE categoriesid=@categoresid)

	--删除日志
	UPDATE blog_posts set deletetag=0 WHERE categoriesid=@categoresid

	--删除日志记录
	--exec [sys_actionlogs_Delete] @categoresid,9

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
