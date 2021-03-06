USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogPostsGetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：日记管理
--项目名称：zgyeyblog
--说明：
--时间：2009-12-22 10:01:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_BlogPostsGetCount]
@begintime datetime,
@endtime datetime
AS
	DECLARE @count INT
	SELECT @count=count(1)
	FROM
		 blog_posts t1
	 INNER JOIN
		 blog_user t2 ON t1.userid=t2.userid AND t2.activity=1
	 INNER JOIN
		 blog_baseconfig t4 ON t2.userid=t4.userid
	 LEFT JOIN blog_hotposts t3 ON  t1.postid=t3.postid
	WHERE t1.poststatus=1 AND t1.title<>'我的博客开通啦' AND t1.postupdatetime BETWEEN @begintime AND @endtime
	RETURN @count


GO
