USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_class_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途: 添加相册班级显示
--项目名称：BLOG
--说明：
--时间：2009-6-18 11:50:29
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_class_ADD]
@categoriesid int,
@classid int

 AS 
	IF NOT EXISTS(SELECT * FROM album_categories_class WHERE categoriesid=@categoriesid and classid=@classid)
	BEGIN
		INSERT INTO album_categories_class(categoriesid,classid) values (@categoriesid,@classid)
	END

	IF @@ERROR <> 0 
	BEGIN 	
		RETURN(-1)
	END
	ELSE
	BEGIN	
	    RETURN 1
	END	





GO
