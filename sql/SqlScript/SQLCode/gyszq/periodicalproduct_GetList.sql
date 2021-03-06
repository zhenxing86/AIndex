USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[periodicalproduct_GetList]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询期刊商品列表 
--项目名称：ServicePlatform
--说明：
--时间：2010-4-22 14:56:25
------------------------------------
CREATE PROCEDURE [dbo].[periodicalproduct_GetList]
@periodicalid int,
@commonproductcategoryid int
 AS 
		SELECT 
		t1.periodicalproductid,t1.productid,t1.periodicalid,t1.orderno,t1.createdatetime,t1.status,t2.title,t2.imgpath,t2.imgfilename,t2.createdatetime as productcreatedatetime,t3.companyid,t3.companyname,t3.shortname,t2.shorttitle
		 FROM [periodicalproduct] t1 INNER JOIN [product] t2 ON t1.productid=t2.productid
			INNER JOIN  company t3 ON t2.companyid=t3.companyid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and t2.status=1  ORDER BY t1.orderno ASC
GO
