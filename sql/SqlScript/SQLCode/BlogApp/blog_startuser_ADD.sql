USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_startuser_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：明星博客首页显示日志
--项目名称：zgyeyblog
--说明：
--时间：2009-4-28 16:55:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_startuser_ADD]
@userid int,
@postid int,
@isfristpage int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	DECLARE @postcount int
	SELECT @postcount=count(1) FROM blog_startuser WHERE userid=@userid
	IF(@postcount>2)
	BEGIN
		DELETE  blog_startuser  WHERE postid=(SELECT min(postid) FROM blog_startuser  where userid=@userid)
	END

	INSERT INTO blog_startuser(
	[userid],[postid],[isfristpage]
	)VALUES(
	@userid,@postid,@isfristpage
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
