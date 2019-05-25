USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetDateCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：按日期获取日记文章总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-17 15:32:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetDateCount]
@begintime datetime,
@endtime datetime
 AS 
	DECLARE @Temp int
	SELECT @Temp = count(1) FROM  blog_posts WHERE IsHot=0 and deletetag=1 AND postupdatetime BETWEEN @begintime AND @endtime
	RETURN @Temp





GO
