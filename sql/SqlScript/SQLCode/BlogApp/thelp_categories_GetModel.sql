USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_categories_GetModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：zgyeyblog
--说明：
--时间：2008-09-29 22:36:39
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_categories_GetModel]
@categoryid int
 AS 
	SELECT 
	categoryid,parentid,userid,title,description,displayorder,status,documentcount,createdatetime
	 FROM thelp_categories
	 WHERE categoryid=@categoryid 






GO
