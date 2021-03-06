USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_thelp_documents_GetAproveCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询已审核公共文档数
--项目名称：Manage
--说明：
--时间：2009-7-2 22:19:17
------------------------------------
CREATE PROCEDURE [dbo].[Manage_thelp_documents_GetAproveCount]
@categoryid int
 AS
	DECLARE @count INT
	IF(@categoryid=-1)
	BEGIN
		SELECT @count=count(1) FROM thelp_documents where aprove=1 AND publishdisplay=1 
	END
	ELSE
	BEGIN
		SELECT @count=count(1) FROM thelp_documents WHERE aprove=1 AND publishdisplay=1  AND (pubcategoryid=@categoryid or pubcategoryid in (select pubcategoryid from pub_doc_category where parentid=@categoryid))
	END
	RETURN @count




GO
