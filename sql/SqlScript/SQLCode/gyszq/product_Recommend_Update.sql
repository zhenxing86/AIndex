USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_Recommend_Update]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：推荐商品设置
--项目名称：ServicePlatform
--说明：
--时间：2009-9-2 10:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_Recommend_Update]
@productid int,
@companyid int,
@recommend int
 AS 
--	DECLARE @recommend INT 
	DECLARE @recommendcount INT
--	SELECT @recommend=recommend FROM product WHERE productid=@productid
	SELECT @recommendcount=count(1) FROM product WHERE companyid=@companyid and  recommend=1
	
	IF(@recommend=1)
	BEGIN
		IF(@recommendcount=8)
		BEGIN
			UPDATE product SET recommend=0 WHERE productid in (SELECT MIN(productid) FROM product WHERE companyid=@companyid and recommend=1)
			UPDATE product SET recommend=1 WHERE productid=@productid	
		END
		ELSE
		BEGIN
			UPDATE product SET recommend=1 WHERE productid=@productid	
		END
	END	
	ELSE
	BEGIN
		UPDATE product SET recommend=0 WHERE productid=@productid
	END


	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END
GO
