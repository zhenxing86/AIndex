USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_GetTitleCount]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商品记录数 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_GetTitleCount]
@companyid int,
@producttitle nvarchar(50)
 AS 
	DECLARE @count INT
	SELECT	@count=count(1) FROM [product] WHERE companyid=@companyid AND status=1 AND title like '%'+@producttitle+'%'
	RETURN @count
GO
