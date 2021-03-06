USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_article_GetListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：分页取班级文章
--项目名称：ClassHomePage
--说明：
--时间：2009-5-13 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_article_GetListByPage]
@diycategoryid int,
@classid int,
@page int,
@size int,
@userid int
 
 AS
	DECLARE @user int
	SELECT @user=@userid
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
				articleid
			FROM
				class_article
			WHERE
				 classid=@classid and diycategoryid=@diycategoryid and deletetag=1
			ORDER BY
				createdatetime DESC


			SET ROWCOUNT @size
			SELECT
				articleid,diycategoryid,title,userid,author,classid,t1.kid,content,publishdisplay,createdatetime,viewcount,commentcount,
				[dbo].IsRead(@user,articleid,4) AS isread,
				[dbo].NewArticleAttachDatetime(articleid) as newattachedatetime,t2.cname
			FROM
				@tmptable as tmptable
			INNER JOIN
				class_article t1
			ON
				tmptable.tmptableid = t1.articleid
			INNER JOIN Basicdata..[class]  t2
			
			ON
			t1.classid=t2.cid 	
			WHERE
				row > @ignore
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT
				articleid,diycategoryid,title,userid,author,classid,t1.kid,content,publishdisplay,createdatetime,viewcount,commentcount,
				[dbo].IsRead(@user,articleid,4) AS isread,
				[dbo].NewArticleAttachDatetime(articleid) as newattachedatetime,t2.cname
		FROM
			class_article  t1  inner join basicdata..[class]  t2 on t1.classid=t2.cid
		WHERE
			 t1.classid=@classid and t1.diycategoryid=@diycategoryid and t1.deletetag=1
		ORDER BY
			createdatetime DESC
	END	





GO
