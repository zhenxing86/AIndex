USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productphoto_UpdateOrderno]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改一条商品图片排序 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 11:04:18
------------------------------------
CREATE PROCEDURE [dbo].[productphoto_UpdateOrderno]
@productphotoid int,
@orderno int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @curorderno int
	DECLARE @productid int
	DECLARE @nextorderno int
	DECLARE @nextproductphotoid int

	SELECT @curorderno=orderno,@productid=productid FROM productphoto WHERE	productphotoid=@productphotoid
	SELECT @nextorderno=@curorderno+@orderno
	SELECT @nextproductphotoid=productphotoid FROM productphoto WHERE productid=@productid and orderno=@nextorderno
	UPDATE productphoto SET orderno=@nextorderno WHERE productphotoid=@productphotoid
	UPDATE productphoto SET orderno=@curorderno WHERE productphotoid=@nextproductphotoid

	IF(@@ERROR<>0)
	BEGIN	
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END
GO
