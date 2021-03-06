USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcomment_GetList]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询产品留言信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 10:19:51
------------------------------------
CREATE PROCEDURE [dbo].[productcomment_GetList]
@productid int
 AS 
		SELECT 
			productcommentid,productid,author,userid,content,parentid,commentdatetime,contact,fromip
		 FROM [productcomment] WHERE productid=@productid and status=1 ORDER BY commentdatetime DESC
GO
