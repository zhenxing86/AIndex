USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[theme_GetModel]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到模板对象的详细信息 
--项目名称：ServicePlatform
--说明：
--时间：2010-02-14 16:28:40
------------------------------------
CREATE PROCEDURE [dbo].[theme_GetModel]
@themeid int
 AS 
	SELECT 
	themeid,themename,description,status,thumb,usecount
	 FROM theme
	 WHERE themeid=@themeid
GO
