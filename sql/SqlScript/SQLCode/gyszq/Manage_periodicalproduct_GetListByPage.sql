USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_periodicalproduct_GetListByPage]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询期刊商品列表 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-4-22 14:56:25
------------------------------------
CREATE PROCEDURE [dbo].[Manage_periodicalproduct_GetListByPage]
@periodicalid int,
@commonproductcategoryid int,
@page int,
@size int
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

IF(@commonproductcategoryid=0)
BEGIN
	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT t1.periodicalproductid FROM [periodicalproduct] t1 INNER JOIN [product] t2 on t1.productid=t2.productid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and t2.status=1  ORDER BY t1.orderno ASC

		SET ROWCOUNT @size
		SELECT t1.periodicalproductid,t1.productid,t1.periodicalid,t1.orderno,t1.createdatetime,t1.status,t2.title,t3.title as commonproductcategorytitle
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[periodicalproduct] t1 ON tmptable.tmptableid=t1.periodicalproductid
		INNER JOIN	
			[product] t2 ON t1.productid=t2.productid
		LEFT JOIN 
			[commonproductcategory] t3 ON t2.commonproductcategoryid=t3.commonproductcategoryid	
		WHERE 
			row >  @ignore ORDER BY t1.orderno ASC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.periodicalproductid,t1.productid,t1.periodicalid,t1.orderno,t1.createdatetime,t1.status,t2.title,t3.title as commonproductcategorytitle
		 FROM [periodicalproduct] t1 INNER JOIN [product] t2 ON t1.productid=t2.productid LEFT JOIN [commonproductcategory] t3 ON t2.commonproductcategoryid=t3.commonproductcategoryid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and t2.status=1  ORDER BY t1.orderno ASC
	END
END
ELSE
BEGIN
	IF(@page>1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT t1.periodicalproductid FROM [periodicalproduct] t1 INNER JOIN [product] t2 on t1.productid=t2.productid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and t2.status=1  ORDER BY t1.orderno ASC

		SET ROWCOUNT @size
		SELECT t1.periodicalproductid,t1.productid,t1.periodicalid,t1.orderno,t1.createdatetime,t1.status,t2.title,t3.title as commonproductcategorytitle
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[periodicalproduct] t1 ON tmptable.tmptableid=t1.periodicalproductid
		INNER JOIN	
			[product] t2 ON t1.productid=t2.productid
		LEFT JOIN 
			[commonproductcategory] t3 ON t2.commonproductcategoryid=t3.commonproductcategoryid
		WHERE 
			row >  @ignore ORDER BY t1.orderno ASC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		t1.periodicalproductid,t1.productid,t1.periodicalid,t1.orderno,t1.createdatetime,t1.status,t2.title,t3.title as commonproductcategorytitle
		 FROM [periodicalproduct] t1 INNER JOIN [product] t2 ON t1.productid=t2.productid LEFT JOIN [commonproductcategory] t3 ON t2.commonproductcategoryid=t3.commonproductcategoryid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and t2.status=1  ORDER BY t1.orderno ASC
	END
END
GO
