USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[pub_doc_category_GetModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到共享分类详细信息 
--项目名称：BLOG
--说明：
--时间：2009-7-1 16:22:32
------------------------------------
CREATE PROCEDURE [dbo].[pub_doc_category_GetModel]
@pubcategoryid int
 AS 
	SELECT 
	pubcategoryid,parentid,title,description,documentcount,createdatetime
	 FROM [pub_doc_category]
	 WHERE pubcategoryid=@pubcategoryid 





GO
