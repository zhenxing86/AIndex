USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetRssList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询RSS商品信息 
--项目名称：ServicePlatform
--说明：
--时间：2010-3-29 17:29:06
------------------------------------
CREATE PROCEDURE [dbo].[product_GetRssList]
 AS 
	SELECT TOP(100) t1.productid,t1.companyid,t1.title,t1.description,t1.createdatetime,t2.title as categorytitle
	FROM product t1 LEFT JOIN commonproductcategory t2 ON t1.commonproductcategoryid=t2.commonproductcategoryid
	WHERE status=1 ORDER BY t1.createdatetime DESC

GO
