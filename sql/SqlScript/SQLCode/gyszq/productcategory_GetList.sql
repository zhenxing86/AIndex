USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcategory_GetList]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商品分类记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-10 15:00:54
------------------------------------
CREATE PROCEDURE [dbo].[productcategory_GetList]
@companyid int,
@parentid int
 AS 
	IF(@parentid=0)
	BEGIN
		SELECT 
		productcategoryid,companyid,title,parentid,orderno,createdate,display,(SELECT count(1) FROM [productcategory] WHERE parentid=t1.productcategoryid) as childcategorycount
		 FROM [productcategory] t1 where companyid=@companyid and parentid=@parentid ORDER BY orderno
	END
	ELSE
	BEGIN
		SELECT 
		productcategoryid,companyid,title,parentid,orderno,createdate,display,(SELECT count(1) FROM [productcategory] WHERE parentid=t1.productcategoryid) as childcategorycount
		 FROM [productcategory] t1 where companyid=@companyid ORDER BY parentid,orderno
	END
GO
