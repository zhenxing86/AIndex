USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_Update]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：修改相册分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 22:56:46
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_Update]
@categoriesid int,
@title nvarchar(50),
@description nvarchar(100),
@albumdispstatus int,
@isclassdisplay int,
@classid int,
@viewpermission nvarchar(20)
 AS 
	UPDATE album_categories SET 
	[title] = @title,[description] = @description,[albumdispstatus] = @albumdispstatus,[isclassdisplay]=@isclassdisplay,[classid]=@classid,[viewpermission]=@viewpermission
	WHERE categoriesid=@categoriesid 

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END





GO
