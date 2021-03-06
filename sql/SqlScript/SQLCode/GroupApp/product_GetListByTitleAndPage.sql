USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetListByTitleAndPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商品记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_GetListByTitleAndPage]
@companyid int,
@page int,
@size int,
@producttitle nvarchar(50)

 AS 
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
	END

	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT productid FROM product WHERE companyid=@companyid and status=1 and title like '%'+@producttitle+'%' ORDER BY createdatetime DESC

		SET ROWCOUNT @size
		SELECT 	t1.productid,t1.companyid,t1.title,t1.description,t1.imgpath,t1.imgfilename,t1.targethref,t1.createdatetime,t1.commentcount,t1.imgcount,t1.price,t1.productcategoryid,t1.viewcount,t1.productappraisecount,t1.recommend,t2.title as categorytitle,t3.title as commoncategorytitle
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			product t1 ON tmptable.tmptableid=t1.productid
		LEFT JOIN
			[productcategory] t2 on t1.productcategoryid=t2.productcategoryid
		LEFT JOIN 
			[commonproductcategory] t3 on t1.commonproductcategoryid=t3.commonproductcategoryid
		WHERE 
			row >  @ignore ORDER BY t1.createdatetime DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.productid,t1.companyid,t1.title,t1.description,t1.imgpath,t1.imgfilename,t1.targethref,t1.createdatetime,t1.commentcount,t1.imgcount,t1.price,t1.productcategoryid,t1.viewcount,t1.productappraisecount,t1.recommend,t2.title as categorytitle,t3.title as commoncategorytitle
		 FROM [product] t1 LEFT JOIN [productcategory] t2 on t1.productcategoryid=t2.productcategoryid 
				LEFT JOIN [commonproductcategory] t3 on t1.commonproductcategoryid=t3.commonproductcategoryid
		 WHERE t1.companyid=@companyid and t1.status=1 and t1.title like '%'+@producttitle+'%' ORDER BY t1.createdatetime DESC
	END

GO
