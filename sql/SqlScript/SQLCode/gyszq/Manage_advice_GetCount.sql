USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advice_GetCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询建议数 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-24 9:20:09
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advice_GetCount]
 AS 
	DECLARE @count int
	SELECT @count=count(1) FROM [advice] t1 INNER JOIN [company] t2 ON t1.companyid=t2.companyid WHERE t1.status=1 AND t2.status=1
	RETURN @count
GO
