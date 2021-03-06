USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到商品实体对象的商品分类 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_GetModel]
@productid int
 AS 
	SELECT 
	t1.productid,t1.companyid,t1.title,t1.description,t1.imgpath,t1.imgfilename,t1.targethref,t1.createdatetime,t1.commentcount,t1.imgcount,t1.price,t1.productcategoryid,t1.viewcount,t1.productappraisecount,t1.recommend,
	t2.title as productcategoryname,
	--t1.productcategoryname,
	[dbo].[AreaCaptionFromID](t3.province) as province,[dbo].[AreaCaptionFromID](t3.city) as city,t1.commonproductcategoryid,t4.title as commoncategorytitle,t1.headdescription
	 FROM [product] t1 LEFT JOIN [productcategory] t2 ON t1.productcategoryid=t2.productcategoryid LEFT JOIN company t3 ON t1.companyid=t3.companyid LEFT JOIN commonproductcategory t4 ON t1.commonproductcategoryid=t4.commonproductcategoryid
	 WHERE t1.productid=@productid and t1.status=1


GO
