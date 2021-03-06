USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogPostSysCategoryGetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询日记系统分类记录信息 
--项目名称：CodematicDemo
--说明：
--时间：2008-11-21 16:13:17
------------------------------------
create PROCEDURE [dbo].[Manage_BlogPostSysCategoryGetList]
@usertype int
 AS 
	IF(@usertype=0)
	BEGIN
		SELECT id,title,postcount FROM blog_postsyscategory WHERE id in(1,8,9,10,4,11)
	END
	ELSE
	BEGIN
		SELECT id,title,postcount FROM blog_postsyscategory WHERE id in(2,12,13,14,4,11)
	END



GO
