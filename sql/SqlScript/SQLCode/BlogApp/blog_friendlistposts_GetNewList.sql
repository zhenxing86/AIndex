USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_friendlistposts_GetNewList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：分页获取好友日记文章列表
--项目名称：zgyeyblog
--说明：
--时间：2008-10-31 09:21:19
------------------------------------

CREATE PROCEDURE [dbo].[blog_friendlistposts_GetNewList]
@userid int,
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
			postid
		FROM
			blog_posts t1 
		INNER JOIN
			blog_friendlist t2
		ON
			t1.userid=t2.frienduserid
		WHERE t2.userid=@userid and t1.deletetag=1
		ORDER BY
			postdatetime DESC


		SET ROWCOUNT @size
		SELECT
			t1.author,t1.postdatetime,t1.title,t1.[content],t1.userid,t1.postid
		FROM
			@tmptable as tmptable
		INNER JOIN
			blog_posts t1
		ON
			tmptable.tmptableid = t1.postid
		WHERE
			row > @ignore
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		t1.author,t1.postdatetime,t1.title,t1.[content],t1.userid,t1.postid
	FROM
		blog_posts t1
	INNER JOIN
		blog_friendlist t2
	ON
		t1.userid=t2.frienduserid
	where t2.userid=@userid and t1.deletetag=1
	order by postdatetime desc
END





GO
