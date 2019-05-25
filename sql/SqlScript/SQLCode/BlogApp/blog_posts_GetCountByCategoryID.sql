USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetCountByCategoryID]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：日记文章总数
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 06:55:19
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetCountByCategoryID]
@categoriesid int,
@isself int
 AS 
 
 
  
	DECLARE @TempID int
	IF(@isself=0)
	BEGIN
		SELECT @TempID = count(1) FROM blog_posts WHERE categoriesid=@categoriesid AND poststatus=1 and deletetag=1
		RETURN @TempID
	END
	ELSE
	BEGIN
		SELECT @TempID = count(1) FROM blog_posts WHERE categoriesid=@categoriesid and deletetag=1
		RETURN @TempID
	END
	






GO
