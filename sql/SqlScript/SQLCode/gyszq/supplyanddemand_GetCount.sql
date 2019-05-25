USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[supplyanddemand_GetCount]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到供求实体对象的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-26 15:00:28
------------------------------------
CREATE PROCEDURE [dbo].[supplyanddemand_GetCount]
 AS 
	DECLARE @count int
	SELECT @count=count(1) FROM [supplyanddemand] WHERE status=1
	RETURN @count
GO
