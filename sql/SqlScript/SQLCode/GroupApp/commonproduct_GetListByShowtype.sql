USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[commonproduct_GetListByShowtype]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询专区显示商品信息 
--项目名称：ServicePlatform
--说明：
--时间：2010-2-5 9:29:06
------------------------------------
CREATE PROCEDURE [dbo].[commonproduct_GetListByShowtype]
@showtype int,
@commonproductcategoryid int,
@count int
 AS 
	IF(@commonproductcategoryid=0)
	BEGIN
		SELECT top(@count)
			t1.commonproductid,t1.productid,t1.showtype,t1.orderno,t1.createdatetime,t2.title,t2.imgpath,t2.imgfilename,t2.createdatetime as productcreatedatetime,t3.companyid,t3.companyname,t3.shortname
		FROM [commonproduct] t1 INNER JOIN  product t2 ON t1.productid=t2.productid 
				INNER JOIN  company t3 ON t2.companyid=t3.companyid
		WHERE t1.showtype=@showtype and t1.status=1 and t2.status=1 and t3.status=1 ORDER BY t1.orderno ASC
	END
	ELSE
	BEGIN
		SELECT top(@count)
			t1.commonproductid,t1.productid,t1.showtype,t1.orderno,t1.createdatetime,t2.title,t2.imgpath,t2.imgfilename,t2.createdatetime as productcreatedatetime,t3.companyid,t3.companyname,t3.shortname
		FROM [commonproduct] t1 INNER JOIN  product t2 ON t1.productid=t2.productid 
				INNER JOIN  company t3 ON t2.companyid=t3.companyid
		WHERE t1.showtype=@showtype and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and t1.status=1 and t2.status=1 and t3.status=1 ORDER BY t1.orderno ASC
	END

GO
