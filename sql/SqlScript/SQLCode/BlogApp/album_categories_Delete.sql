USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_Delete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除相册分类
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 22:56:46
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_Delete]
@categoriesid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	declare @photocount int
	
	DECLARE @userid int
	DECLARE @orderno int
	SELECT @userid=userid,@photocount=photocount,@orderno=orderno FROM album_categories WHERE categoriesid=@categoriesid
	
	--更新博客相册数量
	UPDATE blog_baseconfig SET albumcount=albumcount-1,photocount=photocount-@photocount WHERE userid=@userid

	update album_categories set orderno=orderno-1 where userid=@userid and orderno>@orderno

	--删除相册
	--DELETE album_categories	 WHERE categoriesid=@categoriesid 
	UPDATE album_categories SET deletetag=0 WHERE categoriesid=@categoriesid 

	--删除相片评论
	delete t1 from album_comments t1 inner join album_photos t2 on t1.photoid=t2.photoid where t2.categoriesid=categoriesid
	--DELETE album_comments WHERE photoid in (SELECT photoid FROM album_photos WHERE categoriesid=@categoriesid)

	--删除相片
	--DELETE album_photos WHERE categoriesid=@categoriesid
	UPDATE album_photos SET deletetag=0 WHERE categoriesid=@categoriesid 

	--删除全班显示
	delete album_categories_class where categoriesid=@categoriesid

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
