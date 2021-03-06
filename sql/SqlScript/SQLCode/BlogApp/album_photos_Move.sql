USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_Move]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



------------------------------------
--用途：移动相片
--项目名称：ZGYEYBLOG
--说明：
--时间：2010-12-16 14:50:00
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_Move]
@photoid int,
@categoriesid int
 AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	

	declare @orderno int	
	declare @categories int
	DECLARE @oldcategoriesid int
	SELECT  @orderno=orderno,@oldcategoriesid=categoriesid FROM album_photos WHERE photoid=@photoid

	--更新相册照片数量
	UPDATE album_categories SET photocount=photocount-1 WHERE categoriesid=@oldcategoriesid	
	
	UPDATE album_photos SET orderno=orderno-1 WHERE categoriesid=@oldcategoriesid and orderno>@orderno and deletetag=1

	DECLARE @maxorderno int	
	SELECT @maxorderno=max(orderno) from album_photos where [categoriesid] = @categoriesid and deletetag=1

	IF(@maxorderno is null)
	BEGIN
		SET @maxorderno=1
	END
	ELSE
	BEGIN
		SET @maxorderno=@maxorderno+1
	END
	UPDATE album_photos SET [categoriesid]=@categoriesid,[orderno]=@maxorderno,[iscover]=0 where photoid=@photoid	
	--更新相册照片数量
	UPDATE album_categories SET photocount=photocount+1 WHERE categoriesid=@categoriesid and deletetag=1	


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
