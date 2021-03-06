USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[commonproduct_GetListByShowtypeNewId]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：随机查询最新商品 
--项目名称：ServicePlatform
--说明：
--时间：2010-2-5 9:29:06
------------------------------------
CREATE PROCEDURE [dbo].[commonproduct_GetListByShowtypeNewId]
@showtype int,
@count int
 AS 
	SELECT top(@count)
		t1.commonproductid,t1.productid,t1.showtype,t1.orderno,t1.createdatetime,t2.title,t2.imgpath,t2.imgfilename,t2.createdatetime as productcreatedatetime,t3.companyid,t3.companyname,t3.shortname
	FROM [commonproduct] t1 INNER JOIN  product t2 ON t1.productid=t2.productid 
			INNER JOIN  company t3 ON t2.companyid=t3.companyid
	WHERE t1.showtype=@showtype and t1.status=1 and t2.status=1 and t3.status=1 ORDER BY newid()
GO
