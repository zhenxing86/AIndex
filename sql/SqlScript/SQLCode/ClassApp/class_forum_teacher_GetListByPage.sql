USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_GetListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：查询教师交流
--项目名称：ClassHomePage
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_teacher_GetListByPage]
@kid int,
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
	END

	IF(@page>1)
	BEGIN	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT classforumid
		FROM class_forum_teacher 
		WHERE parentid = 0 AND status = 1 AND kid=@kid  ORDER BY createdatetime DESC

			SET ROWCOUNT @size
			SELECT
					t1.classforumid, t1.title, t1.contents, t1.userid, t1.author, t1.kid, t1.createdatetime, t1.istop, t1.parentid,
					(SELECT COUNT(1) AS neralytime FROM dbo.class_forum_teacher WHERE (parentid = t1.classforumid) AND (status = 1)) AS commentcount,
					(SELECT MAX(createdatetime) FROM dbo.class_forum_teacher  WHERE (parentid = t1.classforumid) AND (status = 1)) AS newtime,
					t2.bloguserid, 0 AS isblogpost, t1.approve
			FROM
				@tmptable AS tmptable
			INNER JOIN
				class_forum_teacher t1
			ON
				tmptable.tmptableid = t1.classforumid
			 LEFT OUTER JOIN BasicData.dbo.user_bloguser t2 ON t1.userid = t2.userid
			WHERE
				row > @ignore 
			ORDER BY
				t1.createdatetime DESC 
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
				t1.classforumid, t1.title, t1.contents, t1.userid, t1.author, t1.kid, t1.createdatetime, t1.istop, t1.parentid,
				(SELECT COUNT(1) AS neralytime FROM dbo.class_forum_teacher WHERE (parentid = t1.classforumid) AND (status = 1)) AS commentcount,
				(SELECT MAX(createdatetime) FROM dbo.class_forum_teacher  WHERE (parentid = t1.classforumid) AND (status = 1)) AS newtime,
				t2.bloguserid, 0 AS isblogpost, t1.approve
		FROM dbo.class_forum_teacher AS t1 LEFT OUTER JOIN BasicData.dbo.user_bloguser t2 ON t1.userid = t2.userid
		WHERE t1.parentid = 0 AND t1.status = 1 AND t1.kid=@kid  ORDER BY t1.createdatetime DESC
	END










GO
