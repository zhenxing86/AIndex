USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_video_Update]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：修改班级视频 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 15:18:06
------------------------------------
CREATE  PROCEDURE [dbo].[class_video_Update]
@videoid int,
@classid int,
@title nvarchar(100),
@description nvarchar(200)

 AS 
	UPDATE class_video SET 
	[classid] = @classid,[title] = @title,[description] = @description
	WHERE videoid=@videoid 
	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END







GO
