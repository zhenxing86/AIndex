USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproductcategory_GetList]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：专区商品分类列表
--项目名称：ServicePlatformManage
--说明：
--时间：2009-7-11 15:48:11
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproductcategory_GetList]
 AS 
	SELECT commonproductcategoryid,title,parentid,display,orderno FROM commonproductcategory ORDER BY orderno
GO
