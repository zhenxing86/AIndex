USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[pub_doc_category_Delete]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：删除共享分类 
--项目名称：BLOG
--说明：
--时间：2009-7-1 16:22:32
------------------------------------
CREATE PROCEDURE [dbo].[pub_doc_category_Delete]
@pubcategoryid int
 AS 

		DELETE [pub_doc_category] WHERE parentid=@pubcategoryid

		DELETE [pub_doc_category] WHERE pubcategoryid=@pubcategoryid 		


	IF @@ERROR<>0
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END





GO
