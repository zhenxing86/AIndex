USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogPostsGetCount]    Script Date: 2014/11/25 11:50:42 ******/
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
@endtime datetime,
@title nvarchar(100),
@content nvarchar(100)
AS
select getdate()
	DECLARE @count INT
	BEGIN
		SELECT @count=count(1)
		FROM
			 blog_posts t1
		 INNER JOIN
			 basicdata..user_bloguser t2 ON t1.userid=t2.bloguserid
		WHERE 
         t1.poststatus=1 AND t1.title<>'我的博客开通啦' 
         AND t1.title<>'我的成长档案开通啦' 
         AND t1.title<>'我的教学助手开通啦' 
         AND t1.postupdatetime BETWEEN @begintime AND @endtime 
         --AND t1.title like '%'+@title+'%'
         --AND t2.activity=1
	END
select getdate()
select (@count)
		RETURN @count



GO
