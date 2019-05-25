USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_AlbumPhotos_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除照片
--项目名称：zgyeyblog
--说明：
--时间：2009-5-7 10:01:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_AlbumPhotos_Delete]
@photoid int
 AS 
	EXEC album_photos_Delete @photoid

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE 
	BEGIN
		RETURN (1)
	END



GO
