USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_GetCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家分类记录数
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_GetCount]
AS
	DECLARE @count int
	SELECT @count=count(1) FROM companycategory
	RETURN @count
GO
