USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_accesslog_GetProductCategoryCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：统计访问各类别商品的次数
--项目名称：ServicePlatformManage
--说明：
--时间：2010-05-19 16:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_accesslog_GetProductCategoryCount] 
@begintime nvarchar(30),
@endtime nvarchar(30),
@usertype int
AS 
	DECLARE @sql varchar(2000)
	IF(@usertype=1)
	BEGIN
		SET @sql='select commonproductcategoryid,title,parentid,(select count(1) from accesslog t2 inner join product t3 on t2.productid=t3.productid
				where t2.productid>0 and t2.bloguserid>0 and t2.accessdatetime between '''+@begintime+''' and '''+ @endtime+''' and (t3.commonproductcategoryid=t1.commonproductcategoryid or t3.commonproductcategoryid in
				 (select commonproductcategoryid from commonproductcategory where parentid=t1.commonproductcategoryid))) as productcount
				 from commonproductcategory t1 order by parentid,orderno'
	END
	ELSE
	BEGIN
		SET @sql='select commonproductcategoryid,title,parentid,(select count(1) from accesslog t2 inner join product t3 on t2.productid=t3.productid
				where t2.productid>0 and t2.accessdatetime between '''+@begintime+''' and '''+ @endtime+''' and (t3.commonproductcategoryid=t1.commonproductcategoryid or t3.commonproductcategoryid in
				 (select commonproductcategoryid from commonproductcategory where parentid=t1.commonproductcategoryid))) as productcount
				 from commonproductcategory t1 order by parentid,orderno'
	END
	EXEC(@sql)
GO
