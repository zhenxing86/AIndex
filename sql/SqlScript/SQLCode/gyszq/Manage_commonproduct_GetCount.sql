USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproduct_GetCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询专区显示商品列数
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 18:00:01
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproduct_GetCount]
@showtype int,
@commonproductcategoryid int
 AS 
	DECLARE @count INT
	IF(@commonproductcategoryid=0)
	BEGIN
		SELECT @count=count(1) FROM [commonproduct] t1 inner join [product] t2 on t1.productid=t2.productid
			WHERE t1.showtype=@showtype and t1.status=1 and t2.status=1
	END
	ELSE
	BEGIN
		SELECT @count=count(1) FROM [commonproduct] t1 inner join [product] t2 on t1.productid=t2.productid
			WHERE t1.showtype=@showtype and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and t2.status=1
	END
	RETURN @count
GO
