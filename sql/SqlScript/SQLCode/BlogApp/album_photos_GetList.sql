USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_GetList]    Script Date: 2014/11/25 11:50:42 ******/
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
CREATE PROCEDURE [dbo].[album_photos_GetList]
@categoriesid int
 AS 
	SELECT 
	photoid,categoriesid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,net
	 FROM album_photos
	WHERE categoriesid=@categoriesid and deletetag=1
	ORDER BY uploaddatetime desc






GO
