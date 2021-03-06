USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetBlogPostscommentsByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询博客日志级论坛留言回复 
--项目名称：ClassHomePage
--说明：
--时间：2009-4-20 9:52:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_GetBlogPostscommentsByPage]
@postid int,
@page int,
@size int,
@classid int,
@userid int
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
	END

	DECLARE @kid int
	SELECT @kid=kid FROM Basicdata.dbo.class WHERE cid=@classid	

	DECLARE @isclassteacher int
	EXEC @isclassteacher=class_GetIsClassTeacher @userid,@classid
	IF(@isclassteacher=1 or (SELECT  count(1) FROM blogapp.dbo.permissionsetting WHERE kid=@kid and ptype=10)=0)
	BEGIN	
		IF(@page>1)
		BEGIN
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
				SELECT
					commentsid
				FROM
					blogapp.dbo.blog_postscomments
				WHERE
					postsid=@postid
				ORDER BY
					commentdatetime  

				SET ROWCOUNT @size
				SELECT
				t1.commentsid AS classforumid,'' AS title,t1.content AS contents,t2.userid,t1.author,t3.kid,0,t1.commentdatetime AS createdatetime,0 AS istop,t1.postsid AS parentid,t1.fromuserid AS bloguserid ,t1.approve
				FROM
					blogapp.dbo.blog_postscomments t1
				INNER JOIN
					@tmptable as tmptable	
				ON
					tmptable.tmptableid = t1.commentsid
				LEFT JOIN basicdata.dbo.user_bloguser t2 on t1.fromuserid=t2.bloguserid
				LEFT join basicdata.dbo.[user] t3 on t2.userid=t3.userid
				WHERE
					row > @ignore
				ORDER BY
					commentdatetime  
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT
				t1.commentsid AS classforumid,'' AS title,t1.content AS contents,t2.userid,t1.author,t3.kid,0,t1.commentdatetime AS createdatetime,0 AS istop,t1.postsid AS parentid,t1.fromuserid AS bloguserid ,t1.approve
			FROM
				blogapp.dbo.blog_postscomments t1
				LEFT JOIN basicdata.dbo.user_bloguser t2 on t1.fromuserid=t2.bloguserid
				LEFT join basicdata.dbo.[user] t3 on t2.userid=t3.userid
			where t1.postsid=@postid
			order by commentdatetime 
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
					blogapp.dbo.blog_postscomments
				WHERE
					postsid=@postid AND (approve=1 or (fromuserid=@userid and @userid<>0))
				ORDER BY
					commentdatetime  

				SET ROWCOUNT @size
				SELECT
				t1.commentsid AS classforumid,'' AS title,t1.content AS contents,t2.userid,t1.author,t3.kid,0,t1.commentdatetime AS createdatetime,0 AS istop,t1.postsid AS parentid,t1.fromuserid AS bloguserid ,t1.approve
				FROM
					blogapp.dbo.blog_postscomments t1
				INNER JOIN
					@tmptable as tmptable	
				ON
					tmptable.tmptableid = t1.commentsid
				LEFT JOIN basicdata.dbo.user_bloguser t2 on t1.fromuserid=t2.bloguserid
				LEFT join basicdata.dbo.[user] t3 on t2.userid=t3.userid
				WHERE
					row > @ignore
				ORDER BY
					commentdatetime  
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT
				t1.commentsid AS classforumid,'' AS title,t1.content AS contents,t2.userid,t1.author,t3.kid,0,t1.commentdatetime AS createdatetime,0 AS istop,t1.postsid AS parentid,t1.fromuserid AS bloguserid ,t1.approve
			FROM
				blogapp.dbo.blog_postscomments t1
				LEFT JOIN basicdata.dbo.user_bloguser t2 on t1.fromuserid=t2.bloguserid
				LEFT join basicdata.dbo.[user] t3 on t2.userid=t3.userid
			WHERE t1.postsid=@postid  AND (t1.approve=1 or (t1.fromuserid=@userid and @userid<>0))
			ORDER BY commentdatetime 
		END
	END

GO
