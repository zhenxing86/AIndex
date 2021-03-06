USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_ADD_V2]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：增加相片
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 14:50:00
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_ADD_V2]
@categoriesid int,
@title nvarchar(100),
@filename nvarchar(200),
@filepath nvarchar(500),
@filesize int,
@net int
 AS
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	declare @maxorderno int
	DECLARE @userid int
	SELECT @userid=userid FROM album_categories WHERE categoriesid=@categoriesid

	--更新博客相册数量
	UPDATE blog_baseconfig SET photocount=photocount+1 WHERE userid=@userid
	
	SELECT @maxorderno=max(orderno) from album_photos where [categoriesid] = @categoriesid and deletetag=1

	IF(@maxorderno is null)
	BEGIN
		SET @maxorderno=1
	END
	ELSE
	BEGIN
		SET @maxorderno=@maxorderno+1
	END
	--新增相片
	INSERT INTO album_photos(
	[categoriesid],[title],[filename],[filepath],[filesize],[viewcount],[commentcount],[uploaddatetime],[iscover],[isflashshow],[orderno],[deletetag],[net]
	)VALUES(
	@categoriesid,@title,@filename,@filepath,@filesize,0,0,getdate(),0,0,@maxorderno,1,@net
	)
	
	--更新相册照片数量
	UPDATE album_categories SET photocount=photocount+1 WHERE categoriesid=@categoriesid
	
	DECLARE @photoid int
	SET @photoid = @@IDENTITY
	DECLARE @covercount int
	SELECT @covercount=count(1) FROM album_photos WHERE categoriesid=@categoriesid AND iscover=1 and deletetag=1
	IF(@covercount=0)
	BEGIN
		UPDATE album_photos SET iscover=1 WHERE photoid=@photoid
		UPDATE album_categories SET net = @net, coverphoto=@filepath+@filename,coverphotodatetime=getdate() WHERE categoriesid=@categoriesid 

	END

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN @photoid
	END






GO
