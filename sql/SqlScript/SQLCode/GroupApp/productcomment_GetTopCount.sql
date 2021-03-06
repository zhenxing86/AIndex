USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcomment_GetTopCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询商品评论记录数 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 10:19:51
------------------------------------
CREATE PROCEDURE [dbo].[productcomment_GetTopCount]
@productid int
 AS 
	DECLARE @count int
	SELECT @count=count(1) FROM [productcomment] WHERE productid=@productid and status=1 and parentid=0
	RETURN @count

GO
