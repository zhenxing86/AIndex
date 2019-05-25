USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_article_GetCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：分菜单取班级文章数 
--项目名称：ClassHomePage
--说明：
--时间：2009-5-12 15:13:23
------------------------------------
CREATE PROCEDURE [dbo].[class_article_GetCount]
@classid int,
@diycategoryid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM class_article WHERE classid=@classid and  diycategoryid=@diycategoryid and deletetag=1
	RETURN @TempID	



GO
