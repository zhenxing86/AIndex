USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetHotList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到热门商品的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-11-20 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_GetHotList]
@companyid int
 AS 
	SELECT top(12) 
	t1.productid,t1.companyid,t1.title,t1.description,t1.imgpath,t1.imgfilename,t1.targethref,t1.createdatetime,t1.commentcount,t1.imgcount,t1.price,t1.productcategoryid,t1.viewcount,t1.productappraisecount,t1.recommend,t2.title as commoncategorytitle
	 FROM [product] t1 LEFT JOIN [commonproductcategory] t2 ON t1.commonproductcategoryid=t2.commonproductcategoryid
	 WHERE t1.companyid=@companyid AND t1.status=1 ORDER BY t1.viewcount desc


GO
