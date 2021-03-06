USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_MessageBoardComment_Delete]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除留言评论
--项目名称：zgyeyblog
--说明：
--时间：2009-5-7 10:01:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_MessageBoardComment_Delete]
@commentid int,
@category int
 AS 
	IF(@category=1)
	BEGIN 
		EXEC blog_messageboard_Delete @commentid
	END	
	ELSE IF(@category=2)
	BEGIN	
		EXEC blog_postscomments_Delete @commentid
	END
	ELSE IF(@category=3)
	BEGIN
		EXEC album_comments_Delete @commentid
	END
	
	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE 
	BEGIN
		RETURN (1)
	END




GO
