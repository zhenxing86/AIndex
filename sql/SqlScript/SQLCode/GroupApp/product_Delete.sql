USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除一条商品记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_Delete]
@productid int,
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	
	DECLARE @temp INT
	SELECT @temp=companyid FROM product WHERE productid=@productid
	IF(@temp=@companyid)
	BEGIN
--		DELETE [productcomment] WHERE productid=@productid
--	
--		DELETE [productappraise] WHERE productid=@productid
--
--		DELETE [productphoto] WHERE productid=@productid
--
--		DELETE [product] WHERE productid=@productid 
		
		UPDATE productcomment SET status=-1 WHERE productid=@productid

		UPDATE productappraise SET status=-1 WHERE productid=@productid

		UPDATE productphoto SET status=-1 WHERE productid=@productid

		UPDATE product SET status=-1 WHERE productid=@productid

		UPDATE company SET productscount=productscount-1 WHERE companyid=@companyid
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
