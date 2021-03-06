USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[kin_doc_category_GetList]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询幼儿园共享分类列表信息 
--项目名称：BLOG
--说明：
--时间：2009-6-27 16:22:32
------------------------------------
CREATE PROCEDURE [dbo].[kin_doc_category_GetList]
@kid int
 AS
IF not EXISTS(SELECT * FROM [kin_doc_category] WHERE kid=@kid and status=1)
begin
	exec docapp..[kin_doc_category_Init] @kid
end


SELECT 
	kincategoryid,parentid,title,kid,description,documentcount,createdatetime
	 FROM [kin_doc_category] WHERE kid=@kid and status=1 order by displayorder




GO
