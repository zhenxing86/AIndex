USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_theme_GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-19 09:17:07
------------------------------------
CREATE PROCEDURE [dbo].[blog_theme_GetModel]
@themeid int
 AS 
	SELECT 
	themeid,themename,description,status,thumb,usecount
	 FROM blog_theme
	 WHERE themeid=@themeid 






GO
