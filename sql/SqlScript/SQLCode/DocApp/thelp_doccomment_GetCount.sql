USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_doccomment_GetCount]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：文档评论总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-19 15:40:19
------------------------------------
CREATE PROCEDURE [dbo].[thelp_doccomment_GetCount]
@docid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM thelp_doccomment  WHERE docid=@docid
	RETURN @TempID		








GO
