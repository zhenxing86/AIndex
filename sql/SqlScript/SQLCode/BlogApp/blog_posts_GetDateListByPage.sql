USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetDateListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：按日期获取日记文章列表
--项目名称：zgyeyblog
--说明：
--时间：2008-11-17 15:01:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_GetDateListByPage]
@begintime datetime,
@endtime datetime,
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
				blog_posts
			WHERE
				IsHot=0 and deletetag=1 AND postupdatetime BETWEEN @begintime AND @endtime
			ORDER BY
				postupdatetime DESC


			SET ROWCOUNT @size
			SELECT
				postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,IsTop,
				IsSoul,postupdatetime,commentcount,viewcounts,smile,IsHot,dbo.PostCategoryTitle(categoriesid) as CategoryTitle
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
			postid,author,userid,postdatetime,title,content,poststatus,categoriesid,commentstatus,IsTop,
			IsSoul,postupdatetime,commentcount,viewcounts,smile,IsHot,dbo.PostCategoryTitle(categoriesid) as CategoryTitle
		FROM blog_posts
		WHERE  IsHot=0 and deletetag=1 AND postupdatetime BETWEEN @begintime AND @endtime
		order by postupdatetime desc
	END









GO
