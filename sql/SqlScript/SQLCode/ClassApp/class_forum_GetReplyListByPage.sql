USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetReplyListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询级论坛留言回复 
--项目名称：ClassHomePage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_GetReplyListByPage]
@classforumid int,
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

	DECLARE @isclassteacher int
	DECLARE @classid int
	DECLARE @kid int
	SELECT @classid=classid FROM class_forum WHERE classforumid=@classforumid
	SELECT @kid=kid FROM BasicData.dbo.class WHERE cid=@classid	
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
					parentid=@classforumid  and status=1
				ORDER BY
					createdatetime  

				SET ROWCOUNT @size
				SELECT
						t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.classid,t1.createdatetime,t1.istop,t1.parentid,t2.bloguserid,t1.approve
				FROM
					class_forum t1
				INNER JOIN
					@tmptable as tmptable	
				ON
					tmptable.tmptableid = t1.classforumid
				LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
				WHERE
					row > @ignore

		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT
				t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.classid,t1.createdatetime,t1.istop,t1.parentid,t2.bloguserid,t1.approve
			FROM
				class_forum t1
			LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
			where t1.parentid=@classforumid AND t1.status=1
			order by createdatetime 
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
					parentid=@classforumid AND status=1 AND (approve=1 OR (userid=@userid and @userid<>0))
				ORDER BY
					createdatetime  

				SET ROWCOUNT @size
				SELECT
						t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.classid,t1.createdatetime,t1.istop,t1.parentid,t2.bloguserid,t1.approve
				FROM
					class_forum t1
				INNER JOIN
					@tmptable as tmptable	
				ON
					tmptable.tmptableid = t1.classforumid
				LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
				WHERE
					row > @ignore

		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT
				t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.classid,t1.createdatetime,t1.istop,t1.parentid,t2.bloguserid,t1.approve
			FROM
				class_forum t1
			LEFT JOIN BasicData.dbo.user_bloguser AS t2 ON t1.userid = t2.userid
			where t1.parentid=@classforumid AND status=1  AND (approve=1 OR (t1.userid=@userid and @userid<>0))
			order by createdatetime 
		END
	END







GO
