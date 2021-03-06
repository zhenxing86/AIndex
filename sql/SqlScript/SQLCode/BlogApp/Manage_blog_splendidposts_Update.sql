USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_blog_splendidposts_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：精彩博文添加
--项目名称：zgyeyblog
--说明：
--时间：2009-5-11 16:55:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_blog_splendidposts_Update]
@postid int,
@usertype int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	IF(NOT EXISTS (SELECT * FROM blog_splendidposts WHERE postid=@postid))
	BEGIN
		IF(@usertype=1)
		BEGIN
			DECLARE @count int	
			SELECT @count=count(1) FROM blog_splendidposts 
			IF(@count>1)
			BEGIN
				DELETE blog_splendidposts WHERE actiontime=(SELECT MIN(actiontime) FROM blog_splendidposts WHERE usertype=1)
			END
		END
		ELSE
		BEGIN
			DELETE blog_splendidposts WHERE usertype=0
		END	
		INSERT INTO blog_splendidposts(postid,usertype,actiontime) values(@postid,@usertype,getdate())
	END
	ELSE
	BEGIN
		DELETE blog_splendidposts WHERE postid=@postid
	END

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END



GO
