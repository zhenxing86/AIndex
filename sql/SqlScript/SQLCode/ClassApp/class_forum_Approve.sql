USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_Approve]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：审核论坛帖子 
--项目名称：classhomepage
--说明：
--时间：2009-6-24 15:20:13
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_Approve]
@classforumid int,
@forumtype int
 AS 
	DECLARE @approve int
	IF(@forumtype=0)
	BEGIN		
		SELECT @approve=approve FROM class_forum WHERE classforumid=@classforumid
		IF(@approve=1)
		BEGIN
			UPDATE class_forum SET approve=0 WHERE classforumid=@classforumid
		END
		ELSE
		BEGIN
			UPDATE class_forum SET approve=1 WHERE classforumid=@classforumid
		END
	END
	--ELSE IF(@forumtype=1)
	--BEGIN
	--	SELECT @approve=approve FROM blog_posts_class  WHERE postid=@classforumid
	--	IF(@approve=1)
	--	BEGIN
	--		UPDATE blog_posts_class SET approve=0 WHERE postid=@classforumid
	--	END
	--	ELSE
	--	BEGIN
	--		UPDATE blog_posts_class SET approve=1 WHERE postid=@classforumid
	--	END
	--END
	--ELSE IF(@forumtype=2)
	--BEGIN
	--	SELECT @approve=approve FROM blog_postscomments   WHERE commentsid=@classforumid
	--	IF(@approve=1)
	--	BEGIN
	--		UPDATE blog_postscomments  SET approve=0 WHERE commentsid=@classforumid
	--	END
	--	ELSE
	--	BEGIN
	--		UPDATE blog_postscomments  SET approve=1 WHERE commentsid=@classforumid
	--	END
	--END

	IF @@ERROR <> 0 
	BEGIN 	 
	   RETURN(-1)
	END
	ELSE
	BEGIN		
	   RETURN (1)
	END






GO
