USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询商品记录数 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_GetCount]
@companyid int,
@productcategoryid int
 AS 
	DECLARE @count INT
	IF(@productcategoryid>0)
	BEGIN
		SELECT	@count=count(1) FROM [product] WHERE companyid=@companyid AND status=1 AND  (productcategoryid=@productcategoryid  or productcategoryid in (select productcategoryid from productcategory where parentid=@productcategoryid))
	END
	ELSE IF(@productcategoryid=0)
	BEGIN
		SELECT	@count=count(1) FROM [product] WHERE companyid=@companyid AND status=1
	END
	ELSE 
	BEGIN
		SELECT @count=count(1) FROM [product] WHERE companyid=@companyid AND status=1 AND (productcategoryid IS NULL or productcategoryid=0)
	END
	RETURN @count

GO
