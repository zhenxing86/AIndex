USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：热门推荐总数
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-08 10:37:29
------------------------------------
CREATE PROCEDURE [dbo].[blog_hotposts_GetCount]
 AS 
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM blog_hotposts t1	INNER JOIN blog_posts t2 ON	t1.postid=t2.postid
		INNER JOIN 	BasicData.dbo.user_bloguser t3 ON t2.userid=t3.bloguserid
		INNER JOIN BasicData.dbo.[user] t4 on t3.userid=t4.userid
		WHERE t4.deletetag=1
	RETURN @TempID		





GO
