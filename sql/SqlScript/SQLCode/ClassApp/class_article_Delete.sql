USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_article_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除班级文章 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-12 15:13:23
------------------------------------
CREATE PROCEDURE [dbo].[class_article_Delete]
@articleid int,
@userid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	--删除文档附件

	UPDATE class_articleattachs SET status=-1 WHERE articleid=@articleid

	--删除文档评论
	UPDATE class_articlecomments SET status=-1 WHERE articleid=@articleid


	UPDATE class_articlesmastercomment SET status=-1 WHERE articleid=@articleid
	
	--删除文档记录
	UPDATE class_article SET deletetag=-1 WHERE articleid=@articleid




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
