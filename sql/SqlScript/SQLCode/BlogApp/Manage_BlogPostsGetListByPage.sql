USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_BlogPostsGetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
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
CREATE PROCEDURE [dbo].[Manage_BlogPostsGetListByPage]
@begintime datetime,
@endtime datetime,
@title nvarchar(100),
@content nvarchar(100),
@page int,
@size int
 AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT t1.postid
			FROM
				 blog_posts t1
			 INNER JOIN
				 basicdata..user_bloguser t2 ON t1.userid=t2.bloguserid
			WHERE 
                t1.poststatus=1 AND t1.title<>'我的博客开通啦' 
                AND t1.title<>'我的成长档案开通啦' 
                AND t1.title<>'我的教学助手开通啦' 
                AND t1.postupdatetime BETWEEN @begintime AND @endtime 
                --AND t1.title like ''+@title+'%' --AND --t2.activity=1
			ORDER BY t1.postupdatetime DESC


			SET ROWCOUNT @size
			SELECT
				t1.postid,t1.author,t1.userid,t1.title,t1.content,t1.postupdatetime,t1.ishot,
				t3.hotpostid,t3.istop,t4.blogtype,
                dbo.IsSplendidPosts(t1.postid) as issplendidposts,
                dbo.IsSysCategoryRelationPosts(t1.postid) as issyscategoryposts
			 FROM 
				@tmptable as tmptable
			 INNER JOIN
				 blog_posts t1 ON tmptable.tmptableid = t1.postid
			 INNER JOIN
				 basicdata..user_bloguser t2 ON t1.userid=t2.bloguserid
			 INNER JOIN
				 blog_baseconfig t4 ON t1.userid=t4.userid
			 LEFT JOIN 
                 blog_hotposts t3 ON  t1.postid=t3.postid
			WHERE
				row > @ignore
			ORDER BY t1.postupdatetime DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
			SELECT 
				t1.postid,t1.author,t1.userid,t1.title,t1.content,t1.postupdatetime,t1.ishot,
				t3.hotpostid,t3.istop,t4.blogtype,
                dbo.IsSplendidPosts(t1.postid) as issplendidposts,
                dbo.IsSysCategoryRelationPosts(t1.postid) as issyscategoryposts
			FROM
				 blog_posts t1
			 INNER JOIN
				 basicdata..user_bloguser t2 ON t1.userid=t2.bloguserid
			 INNER JOIN
				 blog_baseconfig t4 ON t1.userid=t4.userid
			 LEFT JOIN 
                 blog_hotposts t3 ON  t1.postid=t3.postid
			WHERE 
               t1.poststatus=1 AND t1.title<>'我的博客开通啦' 
               AND t1.title<>'我的成长档案开通啦' 
               AND t1.title<>'我的教学助手开通啦' 
               AND t1.postupdatetime BETWEEN @begintime AND @endtime	
               --AND t1.title like '%'+@title+'%' --AND t2.activity=1
			ORDER BY t1.postupdatetime DESC
	END



GO
