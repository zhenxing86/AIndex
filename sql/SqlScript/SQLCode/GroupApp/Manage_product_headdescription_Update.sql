USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_product_headdescription_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改商家搜索优化描述 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-04-08 15:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_product_headdescription_Update] 
@productid int,
@headdescription nvarchar(200)
 AS 
	UPDATE  product SET headdescription=@headdescription WHERE productid=@productid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END

GO
