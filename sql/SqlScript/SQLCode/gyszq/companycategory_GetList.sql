USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_GetList]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询商家分类记录信息  
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_GetList]
 AS 
	SELECT 
	companycategoryid,title,description,source,orderno,companycount,createdate,parentid
	 FROM [companycategory] WHERE source=1 ORDER BY parentid, orderno
GO
