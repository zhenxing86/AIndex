USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到文档实体对象的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetModel]
@docid int
 AS 
	SELECT 
	docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,classid,kid,kindoccategoryid,pubcategoryid,aprove
	 FROM thelp_documents
	 WHERE docid=@docid 





GO
