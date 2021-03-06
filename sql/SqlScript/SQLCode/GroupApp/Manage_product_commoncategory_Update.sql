USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_product_commoncategory_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：更新商品专区分类
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-27 15:48:11
------------------------------------
CREATE PROCEDURE [dbo].[Manage_product_commoncategory_Update]
@productid int,
@categoryid int
 AS 
	UPDATE product SET commonproductcategoryid=@categoryid,iscategorize=1 WHERE productid=@productid
	

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END

GO
