USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetCountByYear]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：按时间年份查询文档列表数量记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2010-09-28 15:30:07
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetCountByYear]
@documentyear int,
@userid int
 AS
	
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and userid=@userid and year(createdatetime)=@documentyear
	RETURN @TempID








GO
