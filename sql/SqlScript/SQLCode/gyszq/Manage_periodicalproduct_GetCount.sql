USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_periodicalproduct_GetCount]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询期刊商品数
--项目名称：ServicePlatformManage
--说明：
--时间：2010-4-22 14:56:25
------------------------------------
CREATE PROCEDURE [dbo].[Manage_periodicalproduct_GetCount]
@periodicalid int,
@commonproductcategoryid int
 AS 
	DECLARE @count INT
	IF(@commonproductcategoryid=0)
	BEGIN
		SELECT @count=count(1) FROM [periodicalproduct] t1 INNER JOIN [product] t2 ON t1.productid=t2.productid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and t2.status=1
	END
	ELSE
	BEGIN
		SELECT @count=count(1) FROM [periodicalproduct] t1 INNER JOIN [product] t2 ON t1.productid=t2.productid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and t2.status=1
	END
	RETURN @count
GO
