USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_comments_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：照片评论总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-03 15:25:19
------------------------------------
CREATE PROCEDURE [dbo].[album_comments_GetCount]
@photoid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM album_comments  WHERE photoid=@photoid
	RETURN @TempID	




GO
