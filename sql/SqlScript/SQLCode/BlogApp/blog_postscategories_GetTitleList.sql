USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscategories_GetTitleList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取日志分类列表
--项目名称：zgyeyblog
--说明：
--时间：2008-09-30 22:57:13
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscategories_GetTitleList]
@userid int
 AS 
	SELECT 
	categoresid,title
	 FROM blog_postscategories
	 WHERE userid=@userid






GO
