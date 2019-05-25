USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_video_Delete]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：删除班级视频 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE PROCEDURE [dbo].[class_video_Delete]
@videoid int,
@userid int
 AS 
--	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--	BEGIN TRANSACTION	

	DECLARE @classid int
	declare @kid int
	SELECT @classid=classid,@kid=kid FROM class_video WHERE videoid=@videoid 
	
	
--	DELETE class_videocomments
--	 WHERE videoid=@videoid
		UPDATE class_videocomments SET status=-1 WHERE videoid=@videoid
		
--	DELETE class_video
--	 WHERE videoid=@videoid 
		UPDATE class_video SET status=-1 WHERE videoid=@videoid
--	EXEC [class_actionlogs_Delete] @videoid,26



	IF @@ERROR <> 0 
	BEGIN 
	--	ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
	--	COMMIT TRANSACTION
	   RETURN (1)
	END










GO
