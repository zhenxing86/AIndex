USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_photos_ADD_v2]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途: 添加相片 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
CREATE PROCEDURE [dbo].[class_photos_ADD_v2]
@albumid int,
@title nvarchar(100),
@filename nvarchar(200),
@filepath nvarchar(500),
@filesize int,
@net int

 AS 

	--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	--BEGIN TRANSACTION
	
	DECLARE @orderno int
	SELECT @orderno=MAX(orderno) FROM class_photos WHERE albumid=@albumid
	IF(@orderno is null)
	BEGIN
		SET @orderno=1
	END
	ELSE
	BEGIN
		SET @orderno=@orderno+1
	END

	DECLARE @photoid int
	INSERT INTO class_photos(
	[albumid],[title],[filename],[filepath],[filesize],[viewcount],[commentcount],
	[uploaddatetime],[iscover],[isfalshshow],[orderno],[status],[net],kid,cid
	)
	select @albumid,@title,@filename,@filepath,@filesize,0,0,getdate(),0,0,@orderno,1,@net,kid,classid
	from class_album where albumid = @albumid

	SET @photoid = ident_current('class_photos') 
	
	--更新相册照片数量
	UPDATE class_album SET photocount=photocount+1,lastuploadtime=getdate() WHERE albumid=@albumid


	DECLARE @covercount int
	SELECT @covercount=count(1) FROM class_photos WHERE albumid=@albumid AND iscover=1 AND status=1
	IF(@covercount=0)
	BEGIN
		UPDATE class_photos SET iscover=1 WHERE photoid=@photoid
		UPDATE class_album SET coverphoto=@filepath+@filename,coverphotodatetime=getdate(),net=@net WHERE albumid=@albumid
	END

	
	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION
	   RETURN @photoid
	END

GO
