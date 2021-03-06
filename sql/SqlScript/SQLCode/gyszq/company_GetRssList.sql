USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_GetRssList]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询RSS商家信息 
--项目名称：ServicePlatform
--说明：
--时间：2010-3-29 17:29:06
------------------------------------
CREATE PROCEDURE [dbo].[company_GetRssList]
 AS 
	SELECT TOP(100) t1.companyid,t1.companyname,t1.companysynopsis,t1.regdatetime,t2.title as categorytitle
	FROM company t1 LEFT JOIN companycategory t2 ON t1.companycategoryid=t2.companycategoryid WHERE t1.companystatus=1 and t1.status=1 ORDER BY t1.regdatetime DESC
GO
