USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_theme_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取模板总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-03 15:22:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_theme_GetCount]
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM blog_theme  WHERE status=1
	RETURN @TempID		






GO
