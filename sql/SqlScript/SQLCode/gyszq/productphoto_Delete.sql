USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productphoto_Delete]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条商品图片记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 11:04:18
------------------------------------
CREATE PROCEDURE [dbo].[productphoto_Delete]
@productphotoid int,
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	DECLARE @orderno int
	DECLARE @productid int
	DECLARE @temp int
	SELECT @productid=t1.productid,@orderno=t1.orderno,@temp=t2.companyid FROM productphoto t1 INNER JOIN product t2 on t1.productid=t2.productid WHERE t1.productphotoid=@productphotoid
	
	IF(@temp=@companyid)
	BEGIN
		UPDATE productphoto SET orderno=orderno-1 WHERE productid=@productid and orderno>@orderno 

--		DELETE [productphoto] WHERE productphotoid=@productphotoid 
		UPDATE productphoto SET status=-1 WHERE productphotoid=@productphotoid

		UPDATE product SET imgcount=imgcount-1 WHERE productid=@productid
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (-2)
	END

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
