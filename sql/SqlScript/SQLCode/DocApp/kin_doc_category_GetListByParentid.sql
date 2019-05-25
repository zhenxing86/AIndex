USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[kin_doc_category_GetListByParentid]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询共享分类子分类列表信息 
--项目名称：BLOG
--说明：
--时间：2009-6-27 16:22:32
------------------------------------
alter PROCEDURE [dbo].[kin_doc_category_GetListByParentid]
@parentid int,
@kid int
 AS
SELECT 
	kincategoryid,parentid,title,kid,description,documentcount,createdatetime
	 FROM [kin_doc_category] WHERE parentid=@parentid and kid=@kid  and status=1 order by displayorder



GO
