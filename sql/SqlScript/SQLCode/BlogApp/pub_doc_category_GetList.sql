USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[pub_doc_category_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询共享分类子分类列表信息 
--项目名称：BLOG
--说明：
--时间：2009-7-2 9:22:32
------------------------------------
CREATE PROCEDURE [dbo].[pub_doc_category_GetList]
 AS 
	SELECT 
	pubcategoryid,parentid,title,description,documentcount,createdatetime
	 FROM [pub_doc_category] 





GO
