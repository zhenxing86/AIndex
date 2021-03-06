USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_show_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：分类取日志列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-04-27 22:23:18
----------------------------------
CREATE PROCEDURE [dbo].[blog_posts_show_GetListByPage]
@categoriestitle nvarchar(30),
@page int,
@size int
AS
	DECLARE @categoriesid int
	SELECT @categoriesid=id FROM blog_postsyscategory where title=@categoriestitle
	DECLARE @prep int,@ignore int
		
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @posts TABLE
	(
			--定义临时表
		row int IDENTITY (1, 1),
		postid bigint
	)

	IF(@page>1)
	BEGIN
		
		SET ROWCOUNT @prep
		INSERT INTO @posts(postid)
		SELECT t1.postid FROM blog_postsyscategory_relation t4 INNER JOIN  blog_posts t1 ON t1.postid=t4.postid
--		INNER JOIN blog_user t3 ON t3.userid=t1.userid and t3.activity=1
		WHERE t4.categoryid=@categoriesid and t1.poststatus=1 and t1.deletetag=1 ORDER BY t4.actiondate DESC


			SET ROWCOUNT @size
			SELECT
				 t1.postid,t1.author,t1.userid,t1.title,t1.postupdatetime
			FROM
				@posts as preposts
			INNER JOIN
				blog_posts t1
			ON
				preposts.postid = t1.postid
			WHERE
				row > @ignore
			ORDER BY postupdatetime DESC
	END
	ELSE
	BEGIN
--		SET ROWCOUNT @size
		SELECT top(@size) t1.postid,t1.author,t1.userid,t1.title,t1.postupdatetime 
		FROM blog_postsyscategory_relation t4 INNER JOIN  blog_posts t1 ON t1.postid=t4.postid
--		INNER JOIN blog_user t3 ON t3.userid=t1.userid and t3.activity=1
		WHERE t4.categoryid=@categoriesid and t1.poststatus=1 and t1.deletetag=1 ORDER BY t4.actiondate DESC
	END








GO
