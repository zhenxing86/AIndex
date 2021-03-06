USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetRecommendList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：得到推荐商品的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_GetRecommendList]
@companyid int
 AS 
	SELECT 
	productid,companyid,title,description,imgpath,imgfilename,targethref,createdatetime,commentcount,imgcount,price,productcategoryid,viewcount,productappraisecount,recommend
	 FROM [product]
	 WHERE companyid=@companyid and recommend=1 and status=1 ORDER BY createdatetime desc


GO
