USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetBlogPostsListOnTimeByPage]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：按时间查询日志列表所有记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-11 9:25:07
------------------------------------
CREATE PROCEDURE [dbo].[Manage_GetBlogPostsListOnTimeByPage]
@begintime datetime,
@endtime datetime,
@page int,
@size int
 AS

IF(@page>1)
BEGIN
	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @posts TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		postid bigint
	)
	
	SET ROWCOUNT @prep
	INSERT INTO @posts(postid)
		SELECT
			postid
		FROM
			blog_posts	WHERE deletetag=1 and postupdatetime BETWEEN @begintime AND @endtime 
		ORDER BY
			postupdatetime DESC


		SET ROWCOUNT @size
		SELECT
			t1.postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,IsTop,
			IsSoul,postupdatetime,commentcount,viewcounts,smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle
		FROM
			@posts as preposts
		INNER JOIN
			blog_posts t1
		ON
			preposts.postid = t1.postid
		WHERE
			row > @ignore
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,IsTop,
		IsSoul,postupdatetime,commentcount,viewcounts,smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle
	FROM
		blog_posts	WHERE deletetag=1 and postupdatetime BETWEEN @begintime AND @endtime
	order by postupdatetime desc
END





GO
