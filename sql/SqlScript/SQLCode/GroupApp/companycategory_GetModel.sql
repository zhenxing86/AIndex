USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_GetModel]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：得到商家分类实体对象的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_GetModel]
@companycategoryid int
 AS 
	SELECT 
	companycategoryid,title,description,source,orderno,companycount,createdate,parentid
	 FROM [companycategory]
	 WHERE companycategoryid=@companycategoryid 




GO
