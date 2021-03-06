USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_video_GetModel]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：得到班级视频的详细信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE  PROCEDURE [dbo].[class_video_GetModel]
@videoid int
 AS 
--	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--	BEGIN TRANSACTION

	--UPDATE class_video SET viewcount=viewcount+1 WHERE videoid=@videoid 

	SELECT 
	videoid,userid,classid,kid,title,description,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,author,weburl,videotype,net
	 FROM class_video
	 WHERE videoid=@videoid and status=1

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
