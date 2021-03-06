USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_product_shorttitle_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改商品简称 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-02-29 09:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_product_shorttitle_Update] 
@productid int,
@shorttitle nvarchar(20)
 AS 
	UPDATE product SET shorttitle=@shorttitle WHERE productid=@productid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END

GO
