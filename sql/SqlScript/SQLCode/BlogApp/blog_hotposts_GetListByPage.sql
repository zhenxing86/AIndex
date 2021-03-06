USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_hotposts_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：分页取热门推荐列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-08 10:37:29exec [blog_hotposts_GetListByPage] 2,3
------------------------------------
CREATE PROCEDURE [dbo].[blog_hotposts_GetListByPage]
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
		SELECT
			t1.hotpostid
		FROM
			blog_hotposts t1 INNER JOIN blog_posts t2 ON t1.postid=t2.postid 
			INNER JOIN 	BasicData.dbo.user_bloguser t3 ON t2.userid=t3.bloguserid
		INNER JOIN BasicData.dbo.[user] t4 on t3.userid=t4.userid
		WHERE t4.deletetag=1
		ORDER BY
			hotpostid DESC



		SET ROWCOUNT @size
		SELECT
			t1.hotpostid,t1.postid,t1.maintitle,t1.subtitle,t1.mainurl,t1.suburl,t1.orderno,t1.posttype,t1.createdate,t2.title,
			t2.postupdatetime,t2.content,t2.categoriesid,t2.commentcount,t2.viewcounts,dbo.PostCategoryTitle(t2.categoriesid) as CategoryTitle,t2.userid
		FROM
			@tmptable as tmptable
		INNER JOIN
			blog_hotposts t1
		ON
			tmptable.tmptableid = t1.hotpostid
		INNER JOIN 
			blog_posts t2	
		ON
			t1.postid=t2.postid
		WHERE
			row > @ignore
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
			t1.hotpostid,t1.postid,t1.maintitle,t1.subtitle,t1.mainurl,t1.suburl,t1.orderno,t1.posttype,t1.createdate,t2.title,
			t2.postupdatetime,t2.content,t2.categoriesid,t2.commentcount,t2.viewcounts,dbo.PostCategoryTitle(t2.categoriesid) as CategoryTitle,t2.userid
		FROM		
			blog_hotposts t1		
		INNER JOIN 
			blog_posts t2	
		ON
			t1.postid=t2.postid
		INNER JOIN 	BasicData.dbo.user_bloguser t3 ON t2.userid=t3.bloguserid
		INNER JOIN BasicData.dbo.[user] t4 on t3.userid=t4.userid
		WHERE t4.deletetag=1
	order by hotpostid desc
END





GO
