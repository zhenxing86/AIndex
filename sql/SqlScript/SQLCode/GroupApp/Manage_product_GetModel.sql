USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_product_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：取商品信息
--项目名称：ServicePlatformManage
--说明：
--时间：2010-02-23 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_product_GetModel]
@productid int
 AS
	SELECT productid,companyid,title,price,viewcount,headdescription,shorttitle FROM product WHERE productid=@productid


GO
