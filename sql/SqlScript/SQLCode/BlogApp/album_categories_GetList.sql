USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取个人相册列表
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 22:56:46
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_GetList]
	@userid int
 AS 
	SELECT 
	categoriesid,userid,title,description,displayorder,albumdispstatus,photocount,createdatetime,coverphoto as defaultcoverphoto,coverphoto
	 FROM album_categories t1
	 WHERE userid=@userid and deletetag=1





GO
