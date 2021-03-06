USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：查询日志列表记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [blog_posts_GetListByPage] 290234,1,1000,1
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetListByPage]
@userid int,
@page int,
@size int,
@isself int
 AS

--set @isself=0

	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @posts TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		postid bigint
	)
		
	IF(@isself=0)
	BEGIN
	IF(@page>1)
	BEGIN
		
		SET ROWCOUNT @prep
		INSERT INTO @posts(postid)
			SELECT
				postid
			FROM
				blog_posts
			WHERE
				userid=@userid AND poststatus=1 and deletetag=1
			ORDER BY
				istop desc,postupdatetime DESC


			SET ROWCOUNT @size
			SELECT
				t1.postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,IsTop,
				IsSoul,postupdatetime,commentcount,viewcounts,smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle,viewpermission
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
			IsSoul,postupdatetime,commentcount,viewcounts,smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle,viewpermission
		FROM
			blog_posts
		where userid=@userid AND poststatus=1 and deletetag=1
		order by istop desc,postupdatetime desc
	END
	END
	
	
	ELSE
	
	BEGIN
	IF(@page>1)
	BEGIN
		
		
		SET ROWCOUNT @prep
		INSERT INTO @posts(postid)
			SELECT
				postid
			FROM
				blog_posts
			WHERE
				userid=@userid and deletetag=1
			ORDER BY
				istop desc,postupdatetime DESC


			SET ROWCOUNT @size
			SELECT
				t1.postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,IsTop,
				IsSoul,postupdatetime,commentcount,viewcounts,smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle,viewpermission
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
			IsSoul,postupdatetime,commentcount,viewcounts,smile,dbo.PostCategoryTitle(categoriesid) as CategoryTitle,viewpermission
		FROM
			blog_posts
		where userid=@userid and deletetag=1
		order by istop desc,postupdatetime desc
		
		
	END
	END


GO
