USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productphoto_GetCount]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商品图片记录数
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 11:04:18
------------------------------------
CREATE PROCEDURE [dbo].[productphoto_GetCount]
@productid int
 AS 
	DECLARE @count int	
	SELECT @count=count(1) FROM [productphoto] WHERE productid=@productid and status=1
	RETURN @count
GO
