USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[commonproductcategory_GetListById]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：专区商品分类
--项目名称：ServicePlatform
--说明：
--时间：2010-01-29 15:48:11
------------------------------------
CREATE PROCEDURE [dbo].[commonproductcategory_GetListById]
@commonproductcategoryid int
 AS 
	SELECT commonproductcategoryid,title,parentid,display,orderno FROM commonproductcategory WHERE parentid=@commonproductcategoryid ORDER BY orderno


GO
