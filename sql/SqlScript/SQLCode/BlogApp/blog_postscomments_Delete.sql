USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscomments_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：删除日记文章评论
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-02 13:56:50
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscomments_Delete]
@commentsid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @postid int
	SELECT @postid=postsid FROM blog_postscomments where commentsid=@commentsid
	
	--更新贴子评论数
	UPDATE blog_posts SET commentcount=commentcount-1 WHERE postid=@postid
		
	DELETE blog_postscomments WHERE commentsid=@commentsid 

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		--exec sys_actionlogs_ADD 0,'w','deletecomment' ,'99',@commentsid,0,0
	   RETURN (1)
	END









GO
