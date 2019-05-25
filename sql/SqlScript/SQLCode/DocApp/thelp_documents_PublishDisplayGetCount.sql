USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_PublishDisplayGetCount]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询公共文档列表数量记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-21 10:58:07
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_PublishDisplayGetCount]
 AS
	
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and publishdisplay=1
	RETURN @TempID







GO
