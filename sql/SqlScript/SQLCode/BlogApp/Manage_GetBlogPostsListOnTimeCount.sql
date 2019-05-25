USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetBlogPostsListOnTimeCount]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：按时间查询日记文章总数
--项目名称：zgyeyblog
--说明：
--时间：2008-12-11 9:25:07
------------------------------------
CREATE PROCEDURE [dbo].[Manage_GetBlogPostsListOnTimeCount]
@begintime datetime,
@endtime datetime
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM blog_posts 
	WHERE deletetag=1 and postupdatetime BETWEEN @begintime AND @endtime 
	RETURN @TempID	





GO
