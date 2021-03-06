USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articlecomments_Delete]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除班级文章评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_articlecomments_Delete]
@articlecommentid int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	DECLARE @articleid int
	SELECT @articleid=articleid FROM class_articlecomments WHERE articlecommentid=@articlecommentid 
	--更新评论数量	
	UPDATE class_article SET [commentcount]=[commentcount]-1
	 WHERE articleid=@articleid

--	DELETE [class_articlecomments]
--	 WHERE articlecommentid=@articlecommentid 
	UPDATE class_articlecomments SET status=-1 WHERE articlecommentid=@articlecommentid

--	EXEC [class_actionlogs_Delete] @articlecommentid,29
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
