USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_videocomments_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除视频评论 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:53:32
------------------------------------
create PROCEDURE [dbo].[class_videocomments_Delete]
@videocommentid int
 AS 

	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION
	
	DECLARE @videoid int
	SELECT @videoid=videoid FROM class_videocomments WHERE videocommentid=@videocommentid 

	--更新视频评论数量	
	UPDATE class_video SET [commentcount]=[commentcount]-1
	 WHERE videoid=@videoid
	
--	DELETE class_videocomments
--	 WHERE videocommentid=@videocommentid 
		UPDATE class_videocomments SET status=-1 WHERE videocommentid=@videocommentid

	--EXEC [class_actionlogs_Delete] @videocommentid,27
	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION
	   RETURN (1)
	END






GO
