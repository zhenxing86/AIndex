USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_product_status_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商品删除
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-15 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_product_status_Delete]
@productid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	UPDATE productphoto SET status=-1 WHERE productid=@productid
	UPDATE productcomment SET status=-1 WHERE productid=@productid
	UPDATE productappraise SET status=-1 WHERE productid=@productid
	UPDATE t1 SET productscount=productscount-1 FROM company t1 INNER JOIN product t2 ON t1.companyid=t2.companyid WHERE t2.productid=@productid
	UPDATE product SET status=-1 WHERE productid=@productid

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
