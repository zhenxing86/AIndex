USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[commonproductcategory_GetList]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：专区商品分类列表
--项目名称：ServicePlatform
--说明：
--时间：2010-01-29 15:48:11
------------------------------------
CREATE PROCEDURE [dbo].[commonproductcategory_GetList]
 AS 
	SELECT commonproductcategoryid,title,parentid,display,orderno FROM commonproductcategory ORDER BY orderno

GO
