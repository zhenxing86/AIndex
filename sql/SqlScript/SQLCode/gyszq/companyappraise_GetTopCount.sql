USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyappraise_GetTopCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家评价记录信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-13 9:40:48
------------------------------------
CREATE PROCEDURE [dbo].[companyappraise_GetTopCount]
@companyid int
 AS 
	DECLARE @count int
	SELECT @count=count(1) FROM [companyappraise] WHERE companyid=@companyid AND status=1 AND parentid=0 
	RETURN @count
GO
