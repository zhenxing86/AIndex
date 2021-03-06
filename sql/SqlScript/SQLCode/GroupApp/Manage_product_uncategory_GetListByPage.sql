USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_product_uncategory_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取现有未加入专区分类的商品
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-27 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_product_uncategory_GetListByPage]
@companyid int,
@account nvarchar(30),
@companyname nvarchar(50),
@categorytitle nvarchar(20),
@begintime nvarchar(30),
@endtime nvarchar(30),
@returncount int,
@page int,
@size int,
@selecttype int
 AS 

	DECLARE @sql varchar(2000)
	DECLARE @where varchar(200)
	
	SET @sql='DECLARE @prep int,@ignore int
		
		SET @prep = '+cast(@size * @page as varchar)+'
		SET @ignore=@prep - '+cast(@size as varchar)+'

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			productid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(productid)
		SELECT t1.productid FROM product t1 inner join company t2 on t1.companyid=t2.companyid inner join productcategory t3 on t1.productcategoryid=t3.productcategoryid '

	IF(@selecttype=0)
	BEGIN
		SET @where=' where 1=1 and t1.commonproductcategoryid is null and t2.status=1 and t1.status=1'
	END
	ELSE
	BEGIN
		SET @where=' where 1=1 and t1.commonproductcategoryid >0 and t2.status=1 and t1.status=1'
	END
	
	IF(@companyid<>0)
	BEGIN
		SET @where=@where+' AND t2.companyid='+cast(@companyid as varchar)
	END

	IF(@account<>'')
	BEGIN
		SET @where=@where+' AND t2.account like ''%'+@account+'%'''
	END

	IF(@companyname<>'')
	BEGIN
		SET @where=@where+' AND t2.companyname like ''%'+@companyname+'%'''
	END

	IF(@categorytitle<>'')
	BEGIN
		SET @where=@where+' AND t3.title like ''%'+@categorytitle+'%'''
	END

--	IF(@companyid=0 and @account='' and @companyname='' and @categorytitle='')
--	BEGIN
--		SET @where=@where+' AND t1.createdatetime between '''+@begintime+''' and '''+@endtime+''''
--	END

--	IF(@order='')
--	BEGIN
--		SET @order='t1.createdatetime'
--	END

	SET @sql=@sql+@where+' ORDER BY t1.createdatetime DESC

			SET ROWCOUNT '+cast(@size as varchar)+'
			SELECT t1.productid,t1.title,t1.createdatetime,t1.productcategoryid,t2.companyname,t3.title as categorytitle,t1.companyid,t1.commonproductcategoryid
			FROM 
				@tmptable AS tmptable
			INNER JOIN 
				product t1 ON tmptable.productid=t1.productid
			INNER JOIN 
				company t2 ON t1.companyid=t2.companyid
			INNER JOIN
				 productcategory t3 on t1.productcategoryid=t3.productcategoryid
			WHERE 
				row >  @ignore ORDER BY t1.createdatetime DESC'

	IF(@returncount=1)
	BEGIN
		SET @sql='SELECT count(1) as total FROM product t1 inner join company t2 on t1.companyid=t2.companyid INNER JOIN productcategory t3 on t1.productcategoryid=t3.productcategoryid'+@where 

	END

	EXEC(@sql)

GO
