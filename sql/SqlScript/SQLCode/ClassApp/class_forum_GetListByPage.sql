USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：查询级论坛留言 
--项目名称：ClassHomePage
--说明：
--时间：2009-2-13 17:09:59
--[class_forum_GetListByPage] @ClassId=1430,@Page=1,@Size=5,@Userid=69542
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_GetListByPage]
@classid int,
@page int,
@size int,
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
	SELECT @kid=kid FROM BasicData.dbo.class WHERE cid=@classid	

		DECLARE @isclassteacher int
		EXEC @isclassteacher=class_GetIsClassTeacher @userid,@classid

		IF(@isclassteacher=1 or (SELECT  count(1) FROM BlogApp.dbo.permissionsetting WHERE kid=@kid and ptype=10)=0)
		BEGIN
			IF(@page>1)
			BEGIN	
				SET ROWCOUNT @prep
				INSERT INTO @tmptable(tmptableid)
					SELECT
						classforumid
					FROM
						class_forum
					WHERE
						classid=@classid and parentid = 0 AND status = 1
					ORDER BY
						createdatetime DESC 

					SET ROWCOUNT @size
					SELECT	t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.classid,t1.createdatetime,t1.istop,t1.parentid,
--							(SELECT     COUNT(1) AS neralytime
--							FROM          dbo.class_forum AS t2
--							WHERE      (parentid = t1.classforumid) AND (status = 1)) 
							replaycount AS commentcount,
--							(SELECT     MAX(createdatetime) AS Expr1
--							FROM          dbo.class_forum AS t3
--							WHERE      (parentid = t1.classforumid) AND (status = 1))
						  t1.lastreplaytime AS newtime, t2.bloguserid, 0 AS isblogpost, t1.approve	
					FROM
						class_forum t1
					INNER JOIN
						@tmptable AS tmptable
					ON
						tmptable.tmptableid = t1.classforumid
						LEFT OUTER JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
					WHERE
						row > @ignore and t1.classid=@classid
					ORDER BY
						t1.istop desc, t1.createdatetime DESC 
			END
			ELSE
			BEGIN
				SET ROWCOUNT @size
				SELECT     t1.classforumid, t1.title, t1.contents, t1.userid, t1.author, t1.kid, t1.classid, t1.createdatetime, t1.istop, t1.parentid,
--					(SELECT     COUNT(1) AS neralytime
--					FROM          dbo.class_forum AS t2
--					WHERE      (parentid = t1.classforumid) AND (status = 1))
				replaycount AS commentcount,
--					(SELECT     MAX(createdatetime) AS Expr1
--					FROM          dbo.class_forum AS t3
--					WHERE      (parentid = t1.classforumid) AND (status = 1))
					t1.lastreplaytime AS newtime, t2.bloguserid, 0 AS isblogpost, t1.approve
				FROM         dbo.class_forum AS t1 LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
				WHERE  t1.classid=@classid and t1.parentid = 0 AND t1.status = 1
				ORDER BY t1.istop desc, t1.createdatetime DESC
			END
		END
		ELSE
		BEGIN
			IF(@page>1)
			BEGIN	
				SET ROWCOUNT @prep
				INSERT INTO @tmptable(tmptableid)
					SELECT
						classforumid
					FROM
						class_forum
					WHERE
						classid=@classid AND (approve=1 OR (userid=@userid and @userid<>0)) and parentid = 0 AND status = 1
					ORDER BY
						createdatetime DESC 

					SET ROWCOUNT @size
					SELECT
							t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.classid,t1.createdatetime,t1.istop,t1.parentid,
--							(SELECT     COUNT(1) AS neralytime
--							FROM          dbo.class_forum AS t2
--							WHERE      (parentid = t1.classforumid) AND (status = 1))
						replaycount AS commentcount,
--							(SELECT     MAX(createdatetime) AS Expr1
--							FROM          dbo.class_forum AS t3
--							WHERE      (parentid = t1.classforumid) AND (status = 1)) 
							t1.lastreplaytime AS newtime, t2.bloguserid, 0 AS isblogpost, t1.approve	
					FROM
						class_forum t1
					INNER JOIN
						@tmptable AS tmptable
					ON
						tmptable.tmptableid = t1.classforumid
						LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
					WHERE
						row > @ignore and t1.classid=@classid
					ORDER BY
						t1.istop desc, t1.createdatetime DESC 
			END
			ELSE
			BEGIN
				SET ROWCOUNT @size
				SELECT     t1.classforumid, t1.title, t1.contents, t1.userid, t1.author, t1.kid, t1.classid, t1.createdatetime, t1.istop, t1.parentid,
--					(SELECT     COUNT(1) AS neralytime
--					FROM          dbo.class_forum AS t2
--					WHERE      (parentid = t1.classforumid) AND (status = 1)) 
replaycount AS commentcount,
--					(SELECT     MAX(createdatetime) AS Expr1
--					FROM          dbo.class_forum AS t3
--					WHERE      (parentid = t1.classforumid) AND (status = 1))
t1.lastreplaytime AS newtime, t2.bloguserid, 0 AS isblogpost, t1.approve
				FROM         dbo.class_forum AS t1 LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
				WHERE  t1.classid=@classid  AND (t1.approve=1 OR (t1.userid=@userid and @userid<>0)) and t1.parentid = 0 AND t1.status = 1
				ORDER BY t1.istop desc, t1.createdatetime DESC
			END
		END
		
		












GO
