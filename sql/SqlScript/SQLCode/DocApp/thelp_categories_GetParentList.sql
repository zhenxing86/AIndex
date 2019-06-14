USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_categories_GetParentList]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：列出一级目录 
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 22:36:39
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_categories_GetParentList]
	@userid int
 AS 
	SELECT 
	categoryid,parentid,title,description,displayorder,status,documentcount,createdatetime
	 FROM thelp_categories
	 WHERE userid=@userid and parentid=0 and status=1
	 ORDER BY displayorder











GO
