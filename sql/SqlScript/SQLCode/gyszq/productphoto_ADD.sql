USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productphoto_ADD]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条商品图片记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 11:04:18
------------------------------------
CREATE PROCEDURE [dbo].[productphoto_ADD]
@productid int,
@imgname nvarchar(100),
@imgpath nvarchar(200),
@imgfile nvarchar(50)
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @productphotoid int
	DECLARE @photocount int
	DECLARE @orderno int
	SELECT @photocount=count(1) FROM productphoto where productid=@productid
	SET @orderno=@photocount+1


	INSERT INTO [productphoto](
	[productid],[imgname],[imgpath],[imgfile],[orderno],[uploaddatetime],[status]
	)VALUES(
	@productid,@imgname,@imgpath,@imgfile,@orderno,getdate(),1
	)
	SET @productphotoid=@@identity
	
	UPDATE product SET imgcount=imgcount+1 WHERE productid=@productid	
	
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (@productphotoid)
	END
GO
