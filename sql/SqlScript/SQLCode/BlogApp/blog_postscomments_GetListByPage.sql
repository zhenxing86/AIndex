USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscomments_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：取分页日记评论列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-03 14:56:50
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscomments_GetListByPage]
	@postid int,
	@page int,
	@size int,
	@userid int
 AS 

	DECLARE @postuserid int
	SELECT @postuserid=userid FROM blog_posts WHERE postid=@postid

	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)
	END
	IF(@userid=@postuserid)
	BEGIN
		IF(@page>1)
		BEGIN
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
				SELECT 
					commentsid
				FROM	 
					blog_postscomments 
				WHERE postsid=@postid
				order by
					commentdatetime desc

			SET ROWCOUNT @size
			SELECT 
				t1.commentsid,t1.postsid,t1.fromuserid,t1.author,t1.commentdatetime,t1.content,t1.parentid
			FROM 
				@tmptable AS tmptable		
			INNER JOIN
 				blog_postscomments t1
			ON 
				tmptable.tmptableid=t1.commentsid 	
			WHERE
				row>@ignore 
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT 
				commentsid,postsid,fromuserid,author,commentdatetime,content,parentid
			FROM blog_postscomments
			WHERE postsid=@postid
			ORDER BY commentdatetime desc
		END
	END
	ELSE
	BEGIN
		IF(@page>1)
		BEGIN
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
				SELECT 
					commentsid
				FROM	 
					blog_postscomments 
				WHERE postsid=@postid and (private=0 or (private=1 and fromuserid=@userid and @userid>0))
				order by
					commentdatetime desc

			SET ROWCOUNT @size
			SELECT 
				t1.commentsid,t1.postsid,t1.fromuserid,t1.author,t1.commentdatetime,t1.content,t1.parentid
			FROM 
				@tmptable AS tmptable		
			INNER JOIN
 				blog_postscomments t1
			ON 
				tmptable.tmptableid=t1.commentsid 	
			WHERE
				row>@ignore 
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT 
				commentsid,postsid,fromuserid,author,commentdatetime,content,parentid
			FROM blog_postscomments
			WHERE postsid=@postid and (private=0 or (private=1 and fromuserid=@userid and @userid>0))
			ORDER BY commentdatetime desc
		END
	END




GO
