USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：相册总数
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_GetCount]
@userid int
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM album_categories WHERE userid=@userid and deletetag=1
	RETURN @TempID		










GO
