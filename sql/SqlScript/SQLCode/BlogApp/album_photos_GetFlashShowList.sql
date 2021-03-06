USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_GetFlashShowList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：相片列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 14:50:00
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_GetFlashShowList]
	@uid int
 AS 
	SELECT	top 5 
			ap.photoid, ap.categoriesid, ap.title, ap.filename, 
			ap.filepath, ap.filesize, ap.viewcount, ap.commentcount, 
			ap.uploaddatetime, ap.iscover, ap.net
	 FROM album_photos ap 
		 inner join album_categories ac 
			on ap.categoriesid = ac.categoriesid
	WHERE ap.isflashshow = 1 
		and ac.userid = @uid 
		and ap.deletetag = 1 
		and ac.deletetag = 1
	ORDER BY NEWID() desc

GO
