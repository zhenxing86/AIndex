USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetCount]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：查询文档列表数量记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [thelp_documents_GetList] 8,0,0
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetCount]
@categoryid int,
@level int
 AS
	
	DECLARE @TempID int

	IF(@level=0)
	BEGIN
		SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and (categoryid in (SELECT categoryid FROM thelp_categories WHERE parentid=@categoryid) or categoryid=@categoryid)
	END
	ELSE IF (@level=1)
	BEGIN
		SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and categoryid=@categoryid
	END
	RETURN @TempID












GO
