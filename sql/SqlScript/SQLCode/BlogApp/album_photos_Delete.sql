USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



------------------------------------
--用途：删除相片
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 14:50:00
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_Delete]
@photoid int
 AS
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	
	
	declare @orderno int	
	declare @categories int
	DECLARE @categoriesid int
	SELECT @categoriesid=categoriesid FROM album_photos WHERE photoid=@photoid

	--更新相册照片数量
	UPDATE album_categories SET photocount=photocount-1 WHERE categoriesid=@categoriesid

	DECLARE @userid int
	SELECT @userid=userid FROM album_categories WHERE categoriesid=@categoriesid

	--更新博客照片数量
	UPDATE blog_baseconfig SET photocount=photocount-1 WHERE userid=@userid
	
	select @orderno=orderno,@categories=categoriesid from album_photos where photoid=@photoid
	
	update album_photos set orderno=orderno-1 where categoriesid=@categories and orderno>@orderno and deletetag=1
	--删除相片评论
	DELETE album_comments WHERE photoid=@photoid
	
	--删除相片
	--DELETE album_photos	 WHERE photoid=@photoid 
	update album_photos set deletetag=0 where photoid=@photoid

	IF @@ERROR <> 0 
	BEGIN 		
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN		
		COMMIT TRANSACTION
	   RETURN (1)
	END





GO
