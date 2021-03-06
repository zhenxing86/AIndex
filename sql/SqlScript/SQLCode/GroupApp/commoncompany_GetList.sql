USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[commoncompany_GetList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询专区显示品牌商家
--项目名称：ServicePlatform
--说明：
--时间：2010-2-5 10:09:58
------------------------------------
CREATE PROCEDURE [dbo].[commoncompany_GetList]
@commonproductcategoryid int
 AS 
	SELECT top(15)
		t1.commoncompanyid,t1.companyid,t1.commonproductcategoryid,t1.orderno,t1.createdatetime,t2.companyname,t2.productscount,t2.shortname
	FROM [commoncompany] t1 INNER JOIN company t2 ON t1.companyid=t2.companyid
	WHERE t1.commonproductcategoryid=@commonproductcategoryid and  t1.status=1 and t2.status=1 ORDER BY t1.orderno ASC

GO
