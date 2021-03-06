USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_UpdateIsCover]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：设置与取消相片是否封面
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 23:17:42
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_UpdateIsCover]
@photoid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION	

	DECLARE @filepath NVARCHAR(500)
	DECLARE @filename NVARCHAR(200)
	DECLARE @uploaddatetime DATETIME
	DECLARE @categoryid int
	SELECT @categoryid=categoriesid,@filepath=filepath,@filename=filename,@uploaddatetime=uploaddatetime FROM album_photos 
	 WHERE photoid=@photoid
	
	UPDATE album_photos SET 
	[iscover]=0 
	WHERE categoriesid=@categoryid

	UPDATE album_photos SET 
	[iscover] = 1
	WHERE photoid=@photoid 

	UPDATE album_categories SET coverphoto=@filepath+@filename,coverphotodatetime=@uploaddatetime WHERE categoriesid=@categoryid 


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
